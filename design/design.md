# Polyglot Application Design

At its core, Polyglot represents a simple order tracking application. Using Polyglot's RESTful API, users can:

* Submit an order
* Get details about an order
* Create a customer record
* Update a customer record
* Delete a customer record
* Get details about a customer

Additional functionality may be added in the future.

Leveraging a microservices-based approach, Polyglot is split into the following independent services:

* The "orders" service, which is responsible for managing orders.
  * This service implements the ability to submit an order or to get details about an existing order.
* The "customers" service, which is responsible for managing customers.
  * This service implements the functionality to create, update, or delete a customer record, or to get details about an existing customer.

As functionality is added, additional services may be implemented.

Data persistence is handled via a relational database management system (RDBMS); although the application is intended to be RDBMS-agnostic, the initial implementation will use MySQL.

As would be expected from a microservices-based application, all services are specifically designed to be deployed in containers.
