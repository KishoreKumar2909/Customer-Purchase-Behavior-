#create database

create database Retail_Ecommerce;
use Retail_Ecommerce;


#basic select
SELECT *
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

#aggregate function
select sum(quantity * list_price) 
from order_items; 
SELECT stores.store_name, 
 JOIN orders ON stores.store_id = orders.store_id
JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY stores.store_name;      SUM(order_items.quantity * (order_items.list_price - order_items.discount)) AS total_sales
FROM stores;


#Subqueries
SELECT product_name FROM products
WHERE product_id NOT IN (SELECT product_id FROM order_items);

#join
SELECT s.first_name AS staff_first_name, 
       s.last_name AS staff_last_name, 
       s.email AS staff_email,
       m.first_name AS manager_first_name, 
       m.last_name AS manager_last_name
FROM staffs s
LEFT JOIN staffs m ON s.manager_id = m.staff_id;

#Window Function 

SELECT stores.store_name, 
       SUM(order_items.quantity * (order_items.list_price - order_items.discount)) AS total_sales,
       RANK() OVER (ORDER BY SUM(order_items.quantity * (order_items.list_price - order_items.discount)) DESC) AS sales_rank
FROM stores
JOIN orders ON stores.store_id = orders.store_id
JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY stores.store_name;

#Date Function
SELECT order_id, order_date, shipped_date, DATEDIFF(shipped_date, order_date) AS days_to_ship
FROM orders WHERE shipped_date IS NOT NULL;

#Case Statement

SELECT order_id, order_status,
CASE
WHEN order_status = '4' THEN '4 more days to deliver'
WHEN order_status = '3' THEN '3 more days to deliver'
WHEN order_status = '2' THEN '2 more days to deliver'
WHEN order_status = '1' THEN '1 more days to deliver'                              
END AS status_category
FROM orders;

#Complex Join

SELECT orders.order_id, orders.order_date, products.product_name, stores.store_name FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
JOIN stores ON orders.store_id = stores.store_id;

#Temprory Table 
CREATE TEMPORARY TABLE temps_sales AS
SELECT product_id, SUM(quantity * (list_price - discount)) AS total_sales
FROM order_items
GROUP BY product_id;

select * from temps_sales;



