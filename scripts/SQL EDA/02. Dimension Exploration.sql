-- Customer demographics
SELECT DISTINCT country FROM gold.dim_customers;
SELECT DISTINCT material_status FROM gold.dim_customers;
SELECT DISTINCT gender FROM gold.dim_customers;

-- Product categories
SELECT DISTINCT category FROM gold.dim_products;
SELECT DISTINCT subcategory FROM gold.dim_products;
SELECT DISTINCT product_line FROM gold.dim_products;

-- Product hierarchy
SELECT DISTINCT category, subcategory, product_line, product_name 
FROM gold.dim_products
ORDER BY 1, 2, 3, 4;
