require_relative 'connection'
require 'byebug'
require 'json'

# ruby rental_offer/membership.rb 10.0.0.2 5678

class Membership

  def initialize(host, port)
    @host = host
    @port = port
    @memory = {'members' => ['Diego']}
  end

  def start
    Connection.with_open(@host, @port) {|ch, ex| check_membership_deal(ch, ex)}
  end

  private

  def check_membership_deal(channel, exchange)
    queue = channel.queue("", :exclusive => true)
    queue.bind exchange
    puts " [*] Waiting for NEED on the bus... To exit press CTRL+C"

    queue.subscribe(block: true) do |delivery_info, properties, body|
      json = JSON.parse(body)
      next if json['solutions'].empty?
      next if json['solutions'].any? { |s| s['deal_type'] }

      if @memory['members'].include?(json['username'])
        puts "emitted a member deal"
        json['solutions'].map do |s|
          s['deal_type'] = 'member'
          s['price_per_day'] = s['price_per_day'] * 0.9
        end
      else
        puts "emitted a new membership deal"
        json['solutions'].map do |s|
          s['deal_type'] = 'new_membership'
          s['price_per_day'] = s['price_per_day'] * 0.8
        end
      end

      exchange.publish json.to_json
    end
  end

end

Membership.new(ARGV.shift, ARGV.shift).start
