require_relative 'rental_offer_need_packet'
require_relative 'connection'
require 'byebug'

# ruby rental_offer/rental_offer_solution_draft.rb 10.0.0.2 5678

class RentalOfferAudiCars

  def initialize(host, port)
    @host = host
    @port = port
  end

  def start
    Connection.with_open(@host, @port) {|ch, ex| provide_solution(ch, ex)}
  end

  private

  def provide_solution(channel, exchange)
    queue = channel.queue("", :exclusive => true)
    queue.bind exchange
    puts " [*] Waiting for NEED on the bus... To exit press CTRL+C"
    queue.subscribe(block: true) do |delivery_info, properties, body|
      json = JSON.parse(body)

      if json['need'] == 'car_rental_offer' && json['solutions'].size == 0
        json['solutions'] = [{
          'type' => 'car',
          'model' => 'Audi A6',
          'price_per_day' => Random.rand(400..500)
        }]
        exchange.publish json.to_json

        puts " [v] Emitted a solution"
      end
    end
  end

end

RentalOfferAudiCars.new(ARGV.shift, ARGV.shift).start
