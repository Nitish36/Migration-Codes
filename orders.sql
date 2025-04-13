-- Drop tables if they exist
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Table 1: Customers
CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

-- Table 2: Products
CREATE TABLE Products (
    product_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    price REAL NOT NULL
);

-- Table 3: Orders
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Table 4: OrderItems
CREATE TABLE OrderItems (
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Table 5: Payments
CREATE TABLE Payments (
    payment_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    amount REAL NOT NULL,
    payment_date TEXT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert Data into Customers
INSERT INTO Customers (name, email) VALUES ('Alice Johnson', 'alice@example.com');
INSERT INTO Customers (name, email) VALUES ('Bob Smith', 'bob@example.com');
INSERT INTO Customers (name, email) VALUES ('Cathy Brown', 'cathy@example.com');
INSERT INTO Customers (name, email) VALUES ('David Lee', 'david@example.com');

-- Insert Data into Products
INSERT INTO Products (name, price) VALUES ('Laptop', 750.00);
INSERT INTO Products (name, price) VALUES ('Smartphone', 500.00);
INSERT INTO Products (name, price) VALUES ('Headphones', 75.00);
INSERT INTO Products (name, price) VALUES ('Keyboard', 40.00);

-- Insert Data into Orders
INSERT INTO Orders (customer_id, order_date) VALUES (1, '2025-04-10');
INSERT INTO Orders (customer_id, order_date) VALUES (2, '2025-04-11');
INSERT INTO Orders (customer_id, order_date) VALUES (3, '2025-04-12');
INSERT INTO Orders (customer_id, order_date) VALUES (4, '2025-04-12');

-- Insert Data into OrderItems
INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (1, 1, 1);
INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (1, 3, 2);
INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (2, 2, 1);
INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (3, 4, 3);

-- Insert Data into Payments
INSERT INTO Payments (order_id, amount, payment_date) VALUES (1, 900.00, '2025-04-10');
INSERT INTO Payments (order_id, amount, payment_date) VALUES (2, 500.00, '2025-04-11');
INSERT INTO Payments (order_id, amount, payment_date) VALUES (3, 120.00, '2025-04-12');
INSERT INTO Payments (order_id, amount, payment_date) VALUES (4, 0.00, '2025-04-12');
