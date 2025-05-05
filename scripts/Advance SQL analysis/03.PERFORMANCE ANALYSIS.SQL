-- PERFORMANCE ANALYSIS
/*
: Compare actual performance to targets or historical benchmarks
: Helps assess product success and identify trends
*/

-- Analyze each product's yearly sales vs its historical average and previous year's sales
WITH cte AS (
    SELECT 
        YEAR(s.order_date) AS year,
        p.product_name,
        SUM(s.sales_amount) AS total_sales,
        -- Average sales across all years for this product
        AVG(SUM(s.sales_amount)) OVER (PARTITION BY p.product_name) AS avg_sales,
        -- Previous year's sales for year-over-year comparison
        LAG(SUM(s.sales_amount)) OVER (
            PARTITION BY p.product_name 
            ORDER BY YEAR(s.order_date)
        ) AS previous_sales
    FROM gold.fact_sales s
    JOIN gold.dim_products p ON p.product_key = s.product_key
    WHERE s.order_date IS NOT NULL
    GROUP BY p.product_name, YEAR(s.order_date)
)

SELECT 
    year,
    product_name,
    total_sales,
    avg_sales,
    -- Difference from average sales
    total_sales - avg_sales AS diff_avg,
    CASE 
        WHEN total_sales - avg_sales > 0 THEN 'Above Avg'
        WHEN total_sales - avg_sales < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,
    
    previous_sales,
    -- Year-over-year sales change
    total_sales - previous_sales AS diff_prv,
    CASE 
        WHEN total_sales - previous_sales > 0 THEN 'Increase'
        WHEN total_sales - previous_sales < 0 THEN 'Decrease'
        ELSE 'No change'
    END AS py_chane
FROM cte;
