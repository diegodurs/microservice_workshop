require_relative 'rental_offer_need_packet'
require_relative 'connection'

class RentalOfferBestSolution

  def initialize(host, port)
    @host = host
    @port = port
    @memory = {}
  end

  def start
    Connection.with_open(@host, @port) {|ch, ex| find_best_solution(ch, ex)}
  end

  private

  def find_best_solution(channel, exchange)
    queue = channel.queue("", :exclusive => true)
    queue.bind exchange
    puts " [*] Waiting for NEED on the bus... To exit press CTRL+C"
    queue.subscribe(block: true) do |delivery_info, properties, body|
      json = JSON.parse(body)
      return unless json['need'] == 'car_rental_offer'

      solutions = (@memory[json['id']] || []) + json['solutions']

      @memory[json['id']] = solutions.uniq

      unless solutions.empty?
        puts "Best solution for #{json['id']}: #{best_solution(solutions)} out of #{solutions.map {|s| s['model']}.join(', ')}"
      end
      # exchange.publish json.merge({
      #   'best_solution' => best_solution(solutions)
      # })
    end
  end

  def best_solution(solutions)
    solutions.sort do |a, b|
      a['price_per_day'].to_f <=> b['price_per_day'].to_f
    end.last
  end
end

RentalOfferBestSolution.new(ARGV.shift, ARGV.shift).start
