-- PART-TO-WHOLE ANALYSIS
/*
: Analyze how individual parts contribute to the overall total
: Helps identify which categories or subcategories drive business impact
*/

-- Category-level share of total sales
WITH cat_share AS (
    SELECT 
        p.category,
        SUM(sales_amount) AS total_sales,
        -- Overall sales across all categories
        SUM(SUM(sales_amount)) OVER () AS over_all_sales
    FROM gold.fact_sales fs
    LEFT JOIN gold.dim_products p ON p.product_key = fs.product_key
    GROUP BY p.category
)
SELECT 
    *,
    CONCAT(ROUND((CAST(total_sales AS FLOAT) / over_all_sales) * 100, 2), '%') AS share_in_sales_%
FROM cat_share
ORDER BY total_sales DESC;

-- Subcategory-level share of total sales (within and across categories)
WITH overall_share AS (
    SELECT 
        p.category,
        p.subcategory,
        SUM(sales_amount) AS total_sales,
        -- Overall sales across all subcategories
        SUM(SUM(sales_amount)) OVER () AS over_all_sales
    FROM gold.fact_sales fs
    LEFT JOIN gold.dim_products p ON p.product_key = fs.product_key
    GROUP BY p.category, p.subcategory
)
SELECT 
    *,
    CONCAT(ROUND((CAST(total_sales AS FLOAT) / over_all_sales) * 100, 2), '%') AS share_in_sales_%
FROM overall_share
ORDER BY total_sales DESC;

/*
: Group customers into segments based on their purchase behavior and relationship duration

- VIP     : ≥ 12 months history and spending > $5000  
- Regular : ≥ 12 months history and spending ≤ $5000  
- New     : < 12 months of history
*/

-- Calculate each customer's total spend and duration of relationship
WITH customer_info AS (
    SELECT  
        customer_key,
        SUM(sales_amount) AS total_spending,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS year_of_relation
    FROM gold.fact_sales
    GROUP BY customer_key
),

-- Classify customers into VIP, Regular, or New
classified_customers AS (
    SELECT 
        customer_key,
        total_spending,
        year_of_relation,
        CASE 
            WHEN total_spending > 5000 AND year_of_relation >= 12 THEN 'VIP'
            WHEN total_spending <= 5000 AND year_of_relation >= 12 THEN 'Regular'
            ELSE 'New'
        END AS customer_group 
    FROM customer_info
)

-- Count customers by segment
SELECT 
    customer_group,
    COUNT(customer_group) AS total_customers
FROM classified_customers 
GROUP BY customer_group
ORDER BY total_customers DESC;

