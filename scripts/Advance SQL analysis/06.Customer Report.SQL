-- ================================================
-- Customer Report View
-- ================================================
/*
Purpose:
- Consolidate customer KPIs and behavioral insights.

Metrics Include:
- Demographics (age, name)
- Purchase activity (orders, quantity, total sales)
- Lifecycle (lifespan, recency)
- Classification (VIP, Regular, New)
- Derived KPIs (AOV, monthly spend)
*/

CREATE VIEW gold.report_customers AS 
WITH customer_info AS (
    SELECT 
        s.order_number,
        s.product_key,
        s.order_date,
        s.sales_amount,
        s.quanity,
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS full_name,
        c.birth_date,
        DATEDIFF(YEAR, c.birth_date, GETDATE()) AS age
    FROM gold.fact_sales s
    LEFT JOIN gold.dim_customers c ON s.customer_key = c.customer_key
    WHERE s.order_date IS NOT NULL
),
customer_agg AS (
    SELECT 
        customer_key,
        customer_number,
        full_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_sales,
        SUM(quanity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(order_date) AS last_order,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespam_months
    FROM customer_info
    GROUP BY customer_key, customer_number, full_name, age
)
SELECT 
    customer_key,
    customer_number,
    full_name,
    age,
    CASE 
        WHEN age < 20 THEN 'below 20'
        WHEN age BETWEEN 20 AND 39 THEN '20-39'
        WHEN age BETWEEN 40 AND 59 THEN '40-59'
        ELSE 'above 60' 
    END AS age_group,
    total_sales,
    total_orders,
    total_products,
    total_quantity,
    last_order,
    lifespam_months,
    CASE 
        WHEN lifespam_months >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespam_months >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New' 
    END AS customer_group,
    DATEDIFF(MONTH, last_order, (SELECT MAX(order_date) FROM gold.fact_sales)) AS recency,
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders 
    END AS average_order_value,
    CASE 
        WHEN lifespam_months = 0 THEN total_sales
        ELSE total_sales / lifespam_months 
    END AS monthly_spend
FROM customer_agg;
