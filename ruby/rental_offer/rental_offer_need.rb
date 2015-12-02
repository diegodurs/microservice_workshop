#!/usr/bin/env ruby
# encoding: utf-8

# Docker run command:
#   docker run --name='workshop_need' -it -v /c/Users/fred/src/microservice_workshop/ruby:/workshop -w /workshop/rental_offer fredgeorge/ruby_microservice:latest bash
# To run monitor at prompt:
#   ruby rental_car_need.rb 192.168.59.103 bugs
#
#
# ruby rental_offer/rental_offer_need.rb 10.0.0.2 5678

require_relative 'rental_offer_need_packet'
require_relative 'connection'
require 'securerandom'

# Expresses a need for rental car offers
class RentalOfferNeed

  def initialize(host, port)
    @host = host
    @port = port
  end

  def start
    Connection.with_open(@host, @port) {|ch, ex| publish_need(ch, ex)}
  end

  private

  def publish_need(channel, exchange)
    loop do
      exchange.publish RentalOfferNeedPacket.new(new_uuid).to_json(username: random_username)
      puts " [x] Published a rental offer need on the bus"
      sleep 5
    end
  end

  def new_uuid
    SecureRandom.uuid.gsub('-', '')
  end

  def random_username
    %w(Diego Simon Lars Fred George)[Random.rand(0..4)]
  end

end

RentalOfferNeed.new(ARGV.shift, ARGV.shift).start
