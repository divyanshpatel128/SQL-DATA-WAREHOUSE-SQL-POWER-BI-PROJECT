-- CUMULATIVE ANALYSIS
/*
: Aggregate the data progressively over time
: Helps understand whether the business is growing or declining
: Makes use of aggregate window functions
*/

-- Monthly sales and running total of sales across all time
SELECT 
    DATETRUNC(MONTH, order_date) AS month,
    SUM(sales_amount) AS total_sales,
    SUM(SUM(sales_amount)) OVER (ORDER BY DATETRUNC(MONTH, order_date)) AS running_total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date);

-- Monthly sales and running total of sales within each year
SELECT 
    DATETRUNC(MONTH, order_date) AS month,
    SUM(sales_amount) AS total_sales,
    SUM(SUM(sales_amount)) OVER (
        PARTITION BY YEAR(DATETRUNC(MONTH, order_date)) 
        ORDER BY DATETRUNC(MONTH, order_date)
    ) AS running_total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date);

-- Monthly average price and its running average within each year
SELECT 
    DATETRUNC(MONTH, order_date) AS month,
    AVG(price) AS avg_price,
    AVG(AVG(price)) OVER (
        PARTITION BY YEAR(DATETRUNC(MONTH, order_date)) 
        ORDER BY DATETRUNC(MONTH, order_date)
    ) AS running_avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date);
