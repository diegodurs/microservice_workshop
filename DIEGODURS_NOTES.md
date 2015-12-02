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

---------------------------------

Create a new packet or add data to the previous one?
- if you add data to the previous one, you don't need to know the whole structure, just can just add a field, that's it.

A service has some required fields (ie: `need: 'car_rental_offer'`) and rejecting field (ie: `not solutions.empty?`)







