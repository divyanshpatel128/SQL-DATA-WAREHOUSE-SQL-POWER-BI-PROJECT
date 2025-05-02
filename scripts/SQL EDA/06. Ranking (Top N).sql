-- Top 5 products by revenue
SELECT TOP 5 product_name, SUM(sales_amount) AS total_sales
FROM gold.fact_sales fs
JOIN gold.dim_products dp ON dp.product_key = fs.product_key
GROUP BY product_name
ORDER BY total_sales DESC;

-- Bottom 5 products by revenue
SELECT TOP 5 product_name, SUM(sales_amount) AS total_sales
FROM gold.fact_sales fs
JOIN gold.dim_products dp ON dp.product_key = fs.product_key
GROUP BY product_name
ORDER BY total_sales ASC;

-- Top 10 customers by revenue
SELECT TOP 10 dc.customer_key, dc.first_name, dc.last_name, SUM(sales_amount) AS total_sales
FROM gold.fact_sales fs
LEFT JOIN gold.dim_customers dc ON dc.customer_key = fs.customer_key
GROUP BY dc.customer_key, dc.first_name, dc.last_name
ORDER BY total_sales DESC;

-- Top 3 customers with most orders placed
SELECT TOP 3 dc.customer_key, dc.first_name, dc.last_name, COUNT(order_number) AS total_orders
FROM gold.fact_sales fs
LEFT JOIN gold.dim_customers dc ON dc.customer_key = fs.customer_key
GROUP BY dc.customer_key, dc.first_name, dc.last_name
ORDER BY total_orders DESC;
