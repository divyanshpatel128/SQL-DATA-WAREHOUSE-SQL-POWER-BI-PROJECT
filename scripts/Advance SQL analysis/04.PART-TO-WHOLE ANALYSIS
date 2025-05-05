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
