#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require "byebug"

class RpcServer

	def initialize(ch)
		@ch = ch
	end

	def start(queue_name)
		@q = @ch.queue(queue_name)
		@x = @ch.default_exchange
		@q.subscribe(:block => true) do |delivery_info, properties, payload|
			process(payload)
			@x.publish(payload, :routing_key => properties.reply_to, :correlation_id => properties.correlation_id)
		end
	end

	def process(payload)
		puts payload
	end

end

def turn_on_rabbit
	conn = Bunny.new(ENV['RABBITMQ_BIGWIG_RX_URL'], automatically_recover: false)
	conn.start
	ch   = conn.create_channel
	begin
		server = RpcServer.new(ch)
		puts " [x] Awaiting RPC requests"
		server.start("rpc_queue")
	rescue Interrupt => _
		ch.close
		conn.close
		exit(0)
	end
end

turn_on_rabbit
