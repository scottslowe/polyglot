# Data Structures for Polyglot

This document outlines the data structures and formats used by Polyglot.

## Orders

### An Order Record in the Database

Polyglot will use a Structured Query Language (SQL)-compatible relational database management system (RDBMS) for the persistent storage of order information.

Within this RDBMS, a single order record will have the following fields:

* _id:_ A unique ID for each order. This ID is assigned by the system, not by the client.
* _customerId:_ The unique ID for the customer placing the order. This is a required field.
* _date:_ The date the order was placed. This value is assigned by the system when an order record is created, not supplied by the user.
* _cost:_ The total cost of the order to the customer. This is a required field.
* _billingRef:_ The customer's PO number, invoice number, or other internal reference. This is an optional field, and may be left blank.

### An Order's Representation in JSON

When an order is retrieved from the database by the orders service and provided to a client via the orders API, the representation of the order resource in JSON will use the "application/vnd.collection+json" media type.

Each order will exist as a JSON object with the following format:

``` json
{
    "href": "http://api.baseDomain/version/orders/orderId",
    "data": [
        { "name": "orderId",
          "value": "<id>" },
        { "name": "customerId",
          "value": "<customerId>" },
        { "name": "orderDate",
          "value": "<date>" },
        { "name": "orderCost",
          "value": "<cost>" },
        { "name": "custBillingRef",
          "value": "<billingRef>" }
    ],
    "links": []
}
```

Assuming that version 1.0 of the orders API is listening at `api.polyglot.scottlowe.org`, then a single order could be represented like this:

``` json
{
    "href": "http://api.polyglot.scottlowe.org/1.0/orders/1001",
    "data": [
        { "name": "orderId",
          "value": "1001" },
        { "name": "customerId",
          "value": "5678" },
        { "name": "orderDate",
          "value": "2019-03-13T14:30:00Z-07" },
        { "name": "orderCost",
          "value": "1123.57" },
        { "name": "custBillingRef",
          "value": "ABC012345" }
    ],
    "links": []
}
```

Orders will be combined into an array called "items", which in turn will be part of a "collection" object, like this:

``` json
{
    "collection": {
        "version": "1.0",
        "href": "http://api.baseDomain/version/",
        "items": [
            {
                "href": "http://api.baseDomain/version/orders/orderId",
                "data": [
                    { "name": "orderId",
                      "value": "<id>" },
                    { "name": "customerId",
                      "value": "<customerId>" },
                    { "name": "orderDate",
                      "value": "<date>" },
                    { "name": "orderCost",
                      "value": "<cost>" },
                    { "name": "custBillingRef",
                      "value": "<billingRef>" }
                ],
                "links": []
            }
        ]
    }
}
```

The `orders-sample.json` provides a sample API response entity body containing two items in the collection.

## Customers

### A Customer Record in the Database

As with order information, Polyglot will use a SQL-compatible RDBMS for the persistent storage of customer information.

Within this RDBMS, a single customer record will have the following fields:

* _id:_ A unique ID for each customer. This ID is assigned by the system, not by the client.
* _streetAddress:_ The number and name of the street address of the customer. This is a required field.
* _unitNumber:_ The suite, apartment, or unit number of the customer. This is an optional field and may be left blank.
* _city:_ The name of the city for the customer's address. This is a required field.
* _state:_ The state of the customer. This is a required field.
* _postalCode:_ The ZIP code for the customer. This is a required field.
* _telephone:_ The 10-digit telephone number for the customer. This is a required field.
* _primaryContactFirstName:_ The first name of the primary contact at the customer. This is a required field.
* _primaryContactLastName:_ The last name of the primary contact at the customer. This is a required field.

At this point, the customer data structure does not need to account for addresses outside the United States, nor does it need to account for multiple contacts at a single customer.

### A Customer's Representation in JSON

When a customer record is retrieved from the database by the customers service and provided to a client via the customers API, the representation of the customer resource in JSON will use the "application/vnd.collection+json" media type.

Each customer will exist as a JSON object with the following format:

``` json
{
    "href": "http://api.baseDomain/version/customers/customerId",
    "data": [
        { "name": "customerId",
          "value": "<id>" },
        { "name": "address",
          "value": "<streetAddress>" },
        { "name": "unit",
          "value": "<unitNumber>" },
        { "name": "city",
          "value": "<city>" },
        { "name": "state",
          "value": "<state>" }
        { "name": "postalCode",
          "value": "<postalCode>" },
        { "name": "telephone",
          "value": "<telephone>" },
        { "name": "contactFirstName",
          "value": "<primaryContactFirstName>" },
        { "name": "contactLastName",
          "value": "<primaryContactLastName>" }
    ],
    "links": []
}
```

Here's an example of how this might look with actual data:

``` json
{
    "href": "http://api.polyglot.scottlowe.org/1.0/customers/5678",
    "data": [
        { "name": "customerId",
          "value": "5678" },
        { "name": "address",
          "value": "123 Main Street" },
        { "name": "unit",
          "value": "Suite 123" },
        { "name": "city",
          "value": "Anywhere" },
        { "name": "state",
          "value": "CO" }
        { "name": "postalCode",
          "value": "80124" },
        { "name": "telephone",
          "value": "3035551212" },
        { "name": "contactFirstName",
          "value": "Scott" },
        { "name": "contactLastName",
          "value": "Lowe" }
    ],
    "links": []
}
```

Multiple customer objects are combined into an array named "items", which is part of an objection named "collection", like this:

``` json
{
    "collection": {
        "href": "http://api.baseDomain/version/customers/",
        "version": "1.0",
        "items": [
            {
                "href": "http://api.baseDomain/version/customers/customerId",
                "data": [
                    { "name": "customerId",
                      "value": "<id>" },
                    { "name": "address",
                      "value": "<streetAddress>" },
                    { "name": "unit",
                      "value": "<unitNumber>" },
                    { "name": "city",
                      "value": "<city>" },
                    { "name": "state",
                      "value": "<state>" }
                    { "name": "postalCode",
                      "value": "<postalCode>" },
                    { "name": "telephone",
                      "value": "<telephone>" },
                    { "name": "contactFirstName",
                      "value": "<primaryContactFirstName>" },
                    { "name": "contactLastName",
                      "value": "<primaryContactLastName>" }
                ],
                "links": []
            }
        ]
    }
}
```

The `customers-sample.json` document provides an example API entity response body.
