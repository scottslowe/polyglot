# Thoughts on Hypermedia

* When the API returns data about a single customer, what other information should accompany that data?
  * A link to the current record, something like `/customers/{customerId}`
  * A link to update the current customer record (how to specify PUT as the HTTP verb in a link?)
  * A link to delete the current customer record (how to specify DELETE as the HTTP verb in a link?)
  * A link to get all the orders for the current customer, something like `/customers/{customerId}/orders`
  * A link to create a new order for the current customer (how to specify PUT as the HTTP verb in a link?)
* When the API returns data about multiple customers, what other information should accompany that data?
  * Each customer record should include a link to the URI for that specific customer's data
  * A link to query/filter data?
