Self-executing mointoring: heartbeat, etc...

Rapids, rivers, ponds.

Kafka: minimize subscribers => create rivers (<10), 0MQ.
    Service subscribe to river, publish to Kafka.

NEED Pattern / architecture.

Q.
How do you know you've received all possible message ?
When stop waiting?
=> Time limit


**Taxonomy:** get the slide


Client

Behavior based services <=> Entity based service // Projections


---------------------------------

1. Run monitoring & the need service.
2. Implement Solution
3. Collect & Save the "Best" solution
4. Provide alternative solution (Simon is having Batmobile)
5. Membership
    6. Member => offer member's special offer
    7. Non-Member => offer to join 

---------------------------------

Create a new packet or add data to the previous one?
- if you add data to the previous one, you don't need to know the whole structure, just can just add a field, that's it.

A service has some required fields (ie: `need: 'car_rental_offer'`) and rejecting field (ie: `not solutions.empty?`)


---------------------------------
Lunch
---------------------------------

"Best": likelihood of user to buy VS value for business

Bus:
    No queue, no topic, no channel; everything on the same bus
        hard to predict who's going to need the messages


Q. Data duplication in messages, ponds size growing exponentially? 
Q. New memeber? command? 

Services will ask ponds to get data, like membership.
Ponds are basically service that just build a state like a projection, events are not the single source of trugh.




