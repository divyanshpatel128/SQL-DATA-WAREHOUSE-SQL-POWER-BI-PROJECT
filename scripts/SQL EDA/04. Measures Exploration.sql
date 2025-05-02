-- Explore fact_sales data
SELECT * 
FROM gold.fact_sales;

-- Total sales
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-- Total quantity sold
SELECT SUM(quanity) AS total_quantity
FROM gold.fact_sales;

-- Average selling price
SELECT AVG(price) AS average_selling_price
FROM gold.fact_sales;

-- Total number of orders
SELECT COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;

-- Total number of products
SELECT COUNT(DISTINCT product_name) AS total_products
FROM gold.dim_products;

-- Total number of customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM gold.dim_customers;

-- Customers who placed at least one order
SELECT COUNT(DISTINCT customer_key) AS total_customer_orders
FROM gold.fact_sales;

-- Business summary report
SELECT 'total sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'total quantity sold', SUM(quanity) FROM gold.fact_sales
UNION ALL
SELECT 'average selling price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'total distinct orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'total products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'total customers', COUNT(DISTINCT customer_id) FROM gold.dim_customers
UNION ALL
SELECT 'total customers that placed an order', COUNT(DISTINCT customer_key) FROM gold.fact_sales;
