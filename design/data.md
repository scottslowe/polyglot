# Data Structures for Polyglot

## Order Data Structure

A single order record will have the following fields:

* _Order ID:_ A unique ID for each order.
* _Customer ID:_ The unique ID for the customer placing the order.
* _Order Date:_ The date the order was placed.
* _Total Cost:_ The total cost of the order to the customer.
* _Customer Billing Reference:_ The customer's PO number, invoice number, or other internal reference (optional).

Represented as JSON, order records would be represented as an array of order objects. A single "order" record would be represented as an array with only a single element, like this:

``` json
{
    "orders": [
        {
            "orderID": "1001",
            "customerID": "5678",
            "orderDate": "2018-07-19 09:00:00 UTC", // Need to finalize date format
            "totalCost": "1123.57",
            "custBillingRef": "ABC012345"
        }
    ]
}
```

## Customer Data Structure

A customer record will have the following fields:

* _Customer ID:_ A unique ID for each customer.
* _Street Address:_ The number and name of the street address of the customer.
* _Unit Number:_ The suite, apartment, or unit number of the customer (optional).
* _City:_ The name of the city for the customer's address.
* _State:_ The state of the customer.
* _Postal Code:_ The ZIP code for the customer.
* _Telephone:_ The 10-digit telephone number for the customer._
* _Primary Contact First Name:_ The first name of the primary contact at the customer.
* _Primary Contact Last Name:_ The last name of the primary contact at the customer.

At this point, the customer data structure does not need to account for addresses outside the United States, nor does it need to account for multiple contacts at a single customer.

When serialized as JSON, customer records are represented as a JSON object within an array, like this:

``` json
{
    "customers": [
        {
            "customerID": "5678",
            "streetAddress": "123 Main Street",
            "unitNumber": "Suite 123",
            "city": "Anywhere",
            "state": "CO",
            "postalCode": "80108",
            "telephone": "3035551212",
            "primaryContactFirstName": "Scott",
            "primaryContactLastName": "Lowe"
        }
    ]
}
```
