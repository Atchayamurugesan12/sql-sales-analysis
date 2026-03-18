CREATE DATABASE sales_analytics;
USE sales_analytics;

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,
city VARCHAR(50),
email VARCHAR(100) UNIQUE,
created_date DATE
);

insert into customers values
(1001, 'Priya sharma', 'Coimbatore', 'priyasharma@gmail.com', '2023-03-13'),
(1002, 'Kalaivani', 'Delhi', 'kalaivani@gmail.com', '2024-01-12'),
(1003, 'Nivetha mohan', 'Pune', 'nivethamohan@gmail.com', '2024-05-04'),
(1004, 'Hanisha', 'Bengalore', 'hanisha89@gmail.com', '2024-12-08'),
(1005, 'Roshini', 'Bengalore', 'roshy@gmail.com', '2025-01-01');

CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2),
stock INT
);

insert into products values
(201, 'Headphones', 'Electronics', 5000.00, 20),
(202, 'Laptop', 'Electronics', 35000.00, 10),
(203, 'Smart phone', 'Electronics', 40000.00, 7),
(204, 'Dinning table', 'Furniture', 50000.00, 25),
(205, 'Water bottle', 'Stationary', 300.00, 28);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

Insert into orders values
(21001, 1005, '2024-04-10', 20000.00),
(21002, 1001, '2024-10-02', 50000.00),
(21003, 1002, '2025-05-02', 50000.00),
(21004, 1003, '2024-05-20', 50000.00),
(21005, 1005, '2025-08-14', 50000.00),
(21006, 1003, '2025-12-24', 50000.00);


CREATE TABLE order_details (
order_detail_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
price DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

Insert into order_details values
(501, 21001, 201, 2, 10000.00),
(502, 21002, 205, 1, 300.00),
(503, 21002, 203, 2, 70000.00),
(504, 21004, 202, 1, 40000.00),
(505, 21003, 205, 4, 12000.00);

