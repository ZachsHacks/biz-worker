#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require "bunny"
require "byebug"

Dir["./models/*.rb"].each {|file| require file}

class TweetsServer

	def initialize(ch)
		@ch = ch
	end

	def start(queue_name)
		queue = @ch.queue(queue_name)
		x = @ch.default_exchange
		queue.subscribe(:block => true) do |delivery_info, properties, payload|
			process(payload)
			x.publish(payload, :routing_key => properties.reply_to, :correlation_id => properties.correlation_id)
		end
	end

	def process(payload)
		tweet = JSON.parse(payload)
		Tweet.connection
		User.connection
		Tweet.create(user_id: tweet[0], username: User.find(tweet[0]).username, body: tweet[1], time: tweet[2])
	end

end

def turn_on_rabbit
	url = 'amqp://_Vjw35MM:GvzbBUIPufAYEOiKlHCyrQzjcX3wfQ3g@lean-hawkbit-1.bigwig.lshift.net:10029/p6ax6MqZ4W6t'
	# /ENV['RABBITMQ_BIGWIG_RX_URL'],
	conn = Bunny.new(url, automatically_recover: false)
	conn.start
	ch   = conn.create_channel
	begin
		server = TweetsServer.new(ch)
		puts "waiting for tweets..."
		server.start("make_tweet_queue")
	rescue Interrupt => _
		ch.close
		conn.close
		exit(0)
	end
end

turn_on_rabbit
