-- CHANGE OVER TIME ANALYSIS
/*
: Analyze how a measure evolves over time
: Helps track trends and identify seasonality in your data 
: Any measure with a date field can be analyzed for time trends
*/

-- Yearly sales performance
SELECT 
    YEAR(order_date) AS year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customer,
    SUM(quanity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

-- Monthly sales performance (aggregated across all years)
SELECT 
    MONTH(order_date) AS month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customer,
    SUM(quanity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

-- Monthly trends using proper date truncation for time series analysis
SELECT 
    DATETRUNC(MONTH, order_date) AS date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customer,
    SUM(quanity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date);

-- Monthly trends with formatted date for better readability in reports
SELECT 
    FORMAT(order_date, 'yyyy-MMM') AS date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customer,
    SUM(quanity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');

-- Top 3 best months per year by sales
SELECT 
    YEAR,
    FULL_DATE,
    higest,
    total_customer,
    total_sales
FROM (
    SELECT  
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        FORMAT(order_date, 'yyyy-MMMM') AS FULL_DATE,
        RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(sales_amount) DESC) AS higest,
        SUM(sales_amount) AS total_sales,
        COUNT(DISTINCT customer_key) AS total_customer,
        SUM(quanity) AS total_quantity
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY 
        YEAR(order_date), 
        MONTH(order_date), 
        FORMAT(order_date, 'yyyy-MMMM')
) t
WHERE higest <= 3
ORDER BY YEAR ASC, higest ASC;

-- Top 3 worst months per year by sales
SELECT 
    YEAR,
    FULL_DATE,
    higest,
    total_customer,
    total_sales
FROM (
    SELECT  
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        FORMAT(order_date, 'yyyy-MMMM') AS FULL_DATE,
        RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(sales_amount)) AS higest,
        SUM(sales_amount) AS total_sales,
        COUNT(DISTINCT customer_key) AS total_customer,
        SUM(quanity) AS total_quantity
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY 
        YEAR(order_date), 
        MONTH(order_date), 
        FORMAT(order_date, 'yyyy-MMMM')
) t
WHERE higest <= 3
ORDER BY YEAR ASC, higest ASC;
