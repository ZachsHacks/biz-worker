#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require "bunny"
require "byebug"

Dir["./models/*.rb"].each {|file| require file}

class RpcServer

	def initialize(ch)
		@ch = ch
	end

	def start(queue_name)
		queue = @ch.queue(queue_name)
		x = @ch.default_exchange
		queue.subscribe(:block => true) do |delivery_info, properties, payload|
			process(payload, queue)
			x.publish(payload, :routing_key => properties.reply_to, :correlation_id => properties.correlation_id)
		end
	end

	def process(payload, queue)
		follow = JSON.parse(payload)
		Follow.connection
		if (Follow.exists?(er_id: follow[0], ing_id: follow[1]))
			puts "Deleting follow for: #{follow}"
			Follow.where(er_id: follow[0], ing_id: follow[1]).destroy_all
		else
			puts "Creating follow for: #{follow}"
			Follow.create(er_id: follow[0], ing_id: follow[1])
		end
	end

end

def turn_on_rabbit
	url = 'amqp://_Vjw35MM:GvzbBUIPufAYEOiKlHCyrQzjcX3wfQ3g@lean-hawkbit-1.bigwig.lshift.net:10029/p6ax6MqZ4W6t'
	# /ENV['RABBITMQ_BIGWIG_RX_URL'],
	conn = Bunny.new(url, automatically_recover: false)
	conn.start
	ch   = conn.create_channel
	begin
		server = RpcServer.new(ch)
		puts "started 'make_follow_queue'"
		server.start("make_follow_queue")
	rescue Interrupt => _
		ch.close
		conn.close
		exit(0)
	end
end

turn_on_rabbit
