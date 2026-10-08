/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/
-- Which categories contribute the most to overall sales?
WITH category_sales AS (
    SELECT 
        category_browsed,
        SUM(amount_spent) AS total_sales
    FROM consumer_behaviour
    GROUP BY category_browsed
)
SELECT 
    category_browsed,
    total_sales,
    SUM(total_sales) OVER() AS overall_sales,
    -- Fixed: Cast the entire calculation block to numeric right before rounding
    ROUND(
        ((total_sales::numeric / NULLIF(SUM(total_sales) OVER (), 0)) * 100)::numeric, 
        2
    ) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;
