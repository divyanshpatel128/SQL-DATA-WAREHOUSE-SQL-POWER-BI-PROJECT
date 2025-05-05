-- DATA SEGMENTATION
/*
: Group data into defined value ranges
: Helps analyze distribution and correlation between attributes (e.g., price and volume)
*/

-- Segment products into cost ranges and count how many products fall into each segment
WITH product_segment AS (
    SELECT 
        product_key, 
        product_name,
        product_cost,
        CASE 
            WHEN product_cost < 100 THEN 'below 100'
            WHEN product_cost BETWEEN 100 AND 499 THEN '100-499'
            WHEN product_cost BETWEEN 500 AND 999 THEN '500-999'
            WHEN product_cost BETWEEN 1000 AND 1499 THEN '1000-1499'
            ELSE 'above 1500'
        END AS price_range
    FROM gold.dim_products
)
SELECT 
    price_range, 
    COUNT(price_range) AS total_product
FROM product_segment
GROUP BY price_range
ORDER BY total_product DESC;
