/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per DATE
-- and the running total of sales over time 
SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
        ROUND(AVG(avg_price) OVER (ORDER BY order_date)::numeric, 2) AS moving_average_price
FROM
(
    SELECT 
        purchase_date::DATE AS order_date,         
        SUM(items_purchased) AS total_sales,
        ROUND(AVG(price_original)::numeric, 2) AS avg_price
    FROM consumer_behaviour
    WHERE purchase_date IS NOT NULL
    GROUP BY purchase_date::DATE                 
) t;
