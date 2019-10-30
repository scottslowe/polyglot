import ballerina/http;
import ballerina/log;
import ballerina/mysql;
import ballerina/config;
import ballerina/io;

// Define what a customer record looks like
type Customer record {
    string streetAddress;
    string unitNumber;
    string city;
    string state;
    string postalCode;
    string telephone;
    string primaryContactFirstName;
    string primaryContactLastName;
}

// Create MySQL endpoint w/ configuration for customers DB
endpoint mysql:Client customersDB {
    host: "localhost",
    port: 3306,
    name: "customers",
    username: "testuser",
    password: "testuser",
    poolOptions: { maximumPoolSize: 5 },
    dbOptions: { useSSL: false }
};

function handleUpdate(int|error returned, string message) {
    match returned {
        int retInt => io:println(message + " status: " + retInt);
        error e => io:println(message + " failed: " + e.message);
    }
}

function retrieveAllCustomers() returns (json) {
    json jsonReturnValue;
    string sqlString = "SELECT * from customers";
    var ret = customersDB->select(sqlString, ());
    match ret {
        table dataTable => {
            jsonReturnValue = check <json>dataTable;
        }
        error err => {
            jsonReturnValue = { "Status": "Data Not Found", "Error": err.message };
        }
    }
    return jsonReturnValue;
}

function retrieveCustomersByState(string state) returns (json) {
    json jsonReturnValue;
    string sqlString = "SELECT * FROM customers WHERE STATE = ?";
    var ret = customersDB->select(sqlString, (), state);
    match ret {
        table dataTable => {
            jsonReturnValue = check <json>dataTable;
        }
        error err => {
            jsonReturnValue = { "Status": "Data Not Found", "Error": err.message };
        }
    }
    return jsonReturnValue;
}

function retrieveCustomersByPostalCode(string postalCode) returns (json) {
    json jsonReturnValue;
    string sqlString = "SELECT * FROM customers WHERE POSTALCODE = ?";
    var ret = customersDB->select(sqlString, (), postalCode);
    match ret {
        table dataTable => {
            jsonReturnValue = check <json>dataTable;
        }
        error err => {
            jsonReturnValue = { "Status": "Data Not Found", "Error": err.message };
        }
    }
    return jsonReturnValue;
}

function retrieveCustomerByID(int id) returns (json) {
    json jsonReturnValue;
    string sqlString = "SELECT * FROM customers WHERE CUSTOMERID = ?";
    var ret = customersDB->select(sqlString, (), id);
    match ret {
        table dataTable => {
            jsonReturnValue = check <json>dataTable;
        }
        error err => {
            jsonReturnValue = { "Status": "Data Not Found", "Error": err.message };
        }
    }
    return jsonReturnValue;
}

function main(string... args) {
    // Retrieve all customer records in JSON format
    json allCustomers = retrieveAllCustomers();
    io:println(io:sprintf("%s", allCustomers));

    // Print the length of the JSON array (number of customers)
    int length;
    length = lengthof allCustomers;
    io:println("Number of Customers: ", length);

    // Retrieve only customers matching the specified target state
    string targetState = "CO";
    json stCustomers = retrieveCustomersByState(targetState);
    io:println(io:sprintf("%s", stCustomers));

    // Retrieve only customers matching the specified target postal code
    string targetPostalCode = "27604";
    json pcCustomers = retrieveCustomersByPostalCode(targetPostalCode);
    io:println(io:sprintf("%s", pcCustomers));

    // Retrieve a specific customer by the customer ID
    int customerID = 2;
    json specCustomer = retrieveCustomerByID(customerID);
    io:println(io:sprintf("%s", specCustomer));
}
