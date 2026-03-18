-- DATA TYPES, KEYS AND CONSTRAINTS

-- 1. Identify all primary keys and foreign keys in the database.
use sales_analytics;
select table_name, column_name from 
information_schema.key_column_usage
where table_schema = 'sales_analytics' AND constraint_name = 'Primary';

select table_name, column_name referenced_table_name, referenced_column_name from
information_schema.key_column_usage
where table_schema = 'sales_analytics' and referenced_table_name is not null;

-- 2. Add a NOT NULL constraint to the category column in products.
alter table products modify category varchar(50) not null;

-- 3. Add a CHECK constraint to ensure price > 0 in products.
Alter table products modify price decimal(10,2) check (price > 0);

-- 4. Change email column datatype to VARCHAR(150).
alter table customers modify email varchar(150);

-- 5. Create a composite primary key for a sample table employee_projects.
create table employee_projects(
Employee_id int, 
Employee_name varchar(50),
project_name varchar(180),
email varchar(50),
project_id varchar(30),
primary key (Employee_id, email, project_id)
);

-- DDL (CREATE, ALTER, DROP)

-- 6. Create a table suppliers with appropriate data types.
create table suppliers (
supplier_id int,
supplier_name varchar(50),
contact_person varchar(50),
Phone_number varchar(15)
);

-- 7. Rename column city to location in customers.
alter table customers change city location varchar(30);

-- 8. Drop the stock column from products.
alter table products drop column stock;

-- 9. Truncate the suppliers table.
Truncate table suppliers;

-- 10. Drop the suppliers table.
drop table suppliers;

-- DML (INSERT, UPDATE, DELETE)

-- 11. Insert 5 records into customers.
insert into customers values
(1006, 'sharmika', 'Bengalore', 'sharmika@gmail.com', '2025-05-06'),
(1007, 'Anita sharma', 'Madurai', 'anitasharma@gmail.com', '2025-08-10'),
(1008, 'Agalya gupta', 'Coimbatore', 'agalyagupta@gmail.com', '2025-10-10'),
(1009, 'Induja', 'Erode', 'induja@gmail.com', '2025-11-15'),
(1010, 'Nikilasri', 'Pudukottai', 'nikilasri@gmail.com', '2026-01-01');

-- 12. Insert 5 records into products.
insert into products values
(206, 'Dressing table', 'Furniture', 25000.00),
(207, 'Chair', 'Furniture', 20000.00),
(208, 'Washing machine', 'Electronics', 40000.00),
(209, 'water heater', 'Electronics', 35000.00),
(210, 'Sofa set', 'Stationary', 30000.00);

-- 13. Update product price by 10% for category 'Electronics'.
Update products set price = price * 1.10 where category = 'Electronics';
select * from products;

-- 14. Delete customers who are from 'Delhi'.
delete from order_details where order_id in 
(select order_id from orders where customer_id in 
(select customer_id from customers where location = 'Delhi'));

-- 15. Insert multiple rows into orders using a single query
Insert into orders values
(22000, 1001, '2025-12-26', 27000.00),
(22001, 1002, '2026-01-05', 40000.00),
(22002, 1003, '2026-01-10', 35000.00);

-- DQL (SELECT)

-- 16. Display all customers sorted by name.
Select Customer_name from customers;

-- 17. Display distinct product categories.
select distinct category from products;

-- 18. Fetch top 5 most expensive products.
select * from products order by price desc limit 5;

-- 19. Display customers created after 2023-01-01.
select * from customers where created_date > '2023-01-01';

-- 20. Show all orders placed in the year 2024.
select * from orders where year(order_date) = 2024;

-- WHERE, LIKE, ORDER BY

-- 21. Find customers whose name starts with 'A'
select * from customers where customer_name like 'A%';

-- 22. Display products priced between 500 and 2000.
select * from products where price > 500 and price < 2000;

-- 23. Fetch orders where total_amount > 10000.
select customer_id, sum(total_amount) as price
from orders 
group by customer_id 
having price > 10000.00;

-- 24. List products ordered by price descending.
select customer_id, sum(total_amount) as Total_price 
from orders
group by customer_id order by Total_price desc;

-- 25. Find customers whose email contains 'gmail'.
select customer_name from customers where email like '%gmail%';

-- Joins

-- 26. Fetch customer name with their order details (INNER JOIN).
select C.customer_name, O.order_id, O.order_date, O.total_amount
from customers as C inner join orders as O
on C.customer_id = O.customer_id;

-- 27. List all customers and their orders (LEFT JOIN).
select C.customer_name, O.order_id, O.order_date, O.total_amount
from customers as C left join orders as O
on C.customer_id = O.customer_id;

-- 28. Show all orders and customers (RIGHT JOIN).
select O.order_id, O.order_date, O.total_amount, C.customer_name 
from customers as C right join orders as O
on C.customer_id = O.customer_id;

-- 29. Display product names with quantities sold.
select P.product_name, O.quantity 
from products as P inner join order_details as O
on P.product_id = O.product_id;

-- 30. Find customers who have not placed any order.
select C.customer_name , O.order_id from customers as C left join orders as O
on C.customer_id = O.customer_id 
where O.order_id is null;

-- Aggregation Functions

-- 31. Find total sales amount.
select sum(price) as total_sales from order_details;

-- 32. Calculate average product price by category.
select category, avg(price) as total_amount 
from products group by category;

-- 33. Find total number of orders per customer.
select customer_id, count(order_id) as Total_order
from orders group by customer_id;

-- 34. Get maximum and minimum product prices.
select max(price) as max_price, min(price) as min_price from products;

-- 35. Count number of customers city-wise.
select location, count(customer_name) as total_customers
from customers group by location;

-- GROUP BY & HAVING

-- 36. Find customers who placed more than 3 orders.
select customer_id, count(order_id) as total_orders
from orders 
group by customer_id
having total_orders > 3;

-- 37. Display categories with average price > 1000.
select category, avg(price) as avg_price
from products 
group by category
having avg_price > 1000.00;

-- 38. Show cities having more than 5 customers.
select location, count(customer_name) as total_customers
from customers 
group by location 
having total_customers > 5;

-- 39. Find products sold more than 50 units
select product_id, sum(quantity) as total_quantity
from order_details 
group by product_id
having total_quantity > 50;

-- 40. Calculate monthly sales and filter months with sales > 1,00,000.
select month(order_date), sum(total_amount) as total_sales
from orders
group by month(order_date) having total_sales > 100000.00;

-- Subqueries

-- 41. Find customers who placed orders above average order value.
select customer_name from customers where customer_id in(
select customer_id from orders where total_amount > (select avg(total_amount) from orders));

-- 42. List products that were never ordered.
select product_name from products where product_id not in ( select product_id from order_details);

-- 43. Find second highest product price.
select product_name from products where price =(select max(price) from products where price < (
select max(price) from products));

-- 44. Get customers who ordered the most expensive product.
select customer_name from customers where customer_id in 
(select customer_id from orders where total_amount =(
select max(total_amount) as highest_price from orders));

-- 45. Delete orders of customers from 'Mumbai' using subquery
delete from orders where customer_id in (select customer_id from customers where location = 'mumbai');

-- Views

-- 46. Create a view showing customer name, order date, and total amount.
create view persons as select customer_name from customers;

create view details as select order_date, total_amount from orders;

-- Index
-- 47. Create an index on order_date in orders table.
create index dates on orders(order_date);

-- Functions

-- 48. Create a user-defined function to calculate GST (18%) on amount.

delimiter //

create function calculate_gst(Amount decimal(10,2))
returns decimal(10,2)
deterministic
Begin
return Amount * 0.18;
end //

delimiter ;

select calculate_gst(40000.00) as total_amount;

-- Stored Procedures
-- 49. Create a stored procedure to fetch orders by customer_id.

delimiter //

create procedure get_customers ( in id int)
begin
select * from orders where customer_id = id;
end //

delimiter ;

call get_customers(1001);

-- Temporary Tables
-- 50. Create a temporary table to store top 5 selling products.
create temporary table top_5_products as
select P.product_name, sum(Od.quantity) as total_quantity
from products as P join order_details as od
on P.product_id = Od.product_id
group by P.product_name order by total_quantity desc limit 5;

select * from top_5_products;
