-- ================================================
-- Product Report View
-- ================================================
/*
Purpose:
- Aggregate product-level metrics and KPIs.

Metrics Include:
- Category-level info (category, subcategory)
- Sales metrics (orders, revenue, quantity, unique customers)
- Lifecycle (recency, duration)
- Product classification by performance
*/

CREATE VIEW gold.report_products AS 
WITH product_info AS (
    SELECT 
        s.order_number,
        s.customer_key,
        s.order_date,
        s.sales_amount,
        s.quanity,
        s.price,
        p.product_key,
        p.product_number,
        p.product_name,
        p.category,
        p.subcategory,
        p.product_line,
        p.start_date
    FROM gold.fact_sales s
    LEFT JOIN gold.dim_products p ON p.product_key = s.product_key
),
product_agg AS (
    SELECT 
        product_key,
        product_name,
        price,
        subcategory,
        category,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_sales,
        SUM(quanity) AS total_quanity,
        COUNT(DISTINCT customer_key) AS total_customers,
        MAX(order_date) AS last_order,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespam_months
    FROM product_info
    GROUP BY category, subcategory, product_name, product_key, price
)
SELECT 
    *,
    CASE 
        WHEN total_sales > 50000 THEN 'High-Performers'
        WHEN total_sales > 10000 THEN 'Mid-Range'
        ELSE 'Low-Performers' 
    END AS product_performance,
    DATEDIFF(MONTH, last_order, (SELECT MAX(order_date) FROM gold.fact_sales)) AS recency,
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders 
    END AS average_order_revenue,
    CASE 
        WHEN lifespam_months = 0 THEN total_sales
        ELSE total_sales / lifespam_months 
    END AS monthly_spend
FROM product_agg;
