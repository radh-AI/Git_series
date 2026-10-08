/*
===============================================================================
Performance Analysis 
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/
WITH state_product_sales AS (
    SELECT
        purchase_date::DATE AS order_date,
        state,
        category_browsed,
        SUM(amount_spent) AS current_sales
    FROM consumer_behaviour
    WHERE purchase_date IS NOT NULL
    GROUP BY purchase_date::DATE, state, category_browsed
)
SELECT 
    order_date,
    state,
    category_browsed,
    current_sales,
    ROUND(AVG(current_sales) OVER(PARTITION BY state)::numeric, 2) AS avg_sales_for_state,
    ROUND((current_sales - AVG(current_sales) OVER(PARTITION BY state))::numeric, 2) AS diff_avg,
    CASE
        WHEN current_sales - AVG(current_sales) OVER(PARTITION BY state) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER(PARTITION BY state) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change
FROM state_product_sales
ORDER BY category_browsed, order_date ASC;
