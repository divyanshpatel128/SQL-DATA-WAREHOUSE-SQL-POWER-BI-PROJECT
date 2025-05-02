-- Order date range
SELECT 
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order,
    DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_date_range_year,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_date_range_month
FROM gold.fact_sales;

-- Customer birthdate analysis
SELECT 
    MIN(birth_date) AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(birth_date), GETDATE()) AS oldest_customer_age,
    MAX(birth_date) AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(birth_date), GETDATE()) AS newest_customer
FROM gold.dim_customers;
