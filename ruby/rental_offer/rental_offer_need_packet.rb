require 'json'

# Understands solutions to a need for a rental car offer
class RentalOfferNeedPacket
  NEED = 'car_rental_offer'

  def initialize(uuid)
    @uuid = uuid
    @solutions = []
  end

  def to_json(*args)
    {
      'json_class' => self.class.name,
      'id' => @uuid,
      'need' => NEED,
      'solutions' => @solutions,
      'username' => args.first[:username]
    }.to_json
  end

  def propose_solution(solution)
    @solutions << solution
  end

end



# {
#  'json_class'
#  'id'
#  'need'
#  'solutions' => {
#     >'deal_type' = [nil, 'member', 'new_membership']
#     'type'
#     'model'
#     'price_per_day' * 0.9 / 0.8
#  }
#  'username'
# }
