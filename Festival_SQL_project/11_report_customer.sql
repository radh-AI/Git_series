/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - average order value
		- average monthly spend
===============================================================================
*/

--1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
CREATE OR REPLACE VIEW public.report_customers AS 
WITH base_query AS (
    SELECT
        customer_id,
        age,
        gender,
        state,
        items_purchased,
        amount_spent,
        category_browsed,
        purchase_date
    FROM public.consumer_behaviour
    WHERE items_purchased IS NOT NULL 
      AND amount_spent IS NOT NULL
),customer_aggregation AS (
    /*---------------------------------------------------------------------------
    2) Customer Aggregations: Summarizes key metrics at the customer level
    ---------------------------------------------------------------------------*/
    SELECT
        customer_id,
        age,
        gender,
        state,
        COUNT(DISTINCT items_purchased) AS total_orders,
        SUM(amount_spent) AS total_sales,
        SUM(items_purchased) AS total_products,
        COUNT(DISTINCT category_browsed) AS total_category,
        MAX(purchase_date) AS last_order_date,
        MIN(purchase_date) AS first_order_date
    FROM base_query
    GROUP BY customer_id, gender, age, state 
)
SELECT 
    customer_id,
    age,
    state,
    CASE
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50 and above'
    END AS age_group,
    total_orders,
    total_sales,
    total_products,
    total_category,
    -- Compute average order value (AOV)
    -- Added a numeric cast and ROUND to ensure you get clean decimal outputs
    CASE 
        WHEN total_sales = 0 THEN 0
        ELSE ROUND((total_sales::numeric / total_orders), 2)
    END AS avg_order_value
FROM customer_aggregation;
