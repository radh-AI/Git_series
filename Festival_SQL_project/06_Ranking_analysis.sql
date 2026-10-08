/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Which 3 category Generating the Highest Revenue?
-- Simple Ranking
SELECT category_browsed,
		sum(amount_spent)as total_revenue
from consumer_behaviour
GROUP by category_browsed
order by total_revenue DESC
LIMIT 3;

-- Complex but Flexibly Ranking Using Window Functions
select *
from (SELECT category_browsed,
		sum(amount_spent)as total_revenue,
		RANK()OVER(ORDER BY sum(amount_spent)DESC)as rank_category
FROM consumer_behaviour
group by category_browsed)as ranked_category
where rank_category <=3;

-- What are the 5 worst-performing category in terms of sales?
SELECT category_browsed,
		sum(amount_spent)as total_revenue
from consumer_behaviour
GROUP by category_browsed
order by total_revenue ASC
LIMIT 5;

-- Find the top 5 customers who have generated the highest revenue
SELECT customer_id,
		category_browsed,
		sum(amount_spent)as total_revenue
from consumer_behaviour
GROUP by category_browsed,customer_id
order by total_revenue DESC
LIMIT 5;

-- The 50 customers with the fewest orders placed
SELECT customer_id,
		category_browsed,
		sum(items_purchased)as total_items
from consumer_behaviour
where items_purchased > 0
GROUP by category_browsed,customer_id
order by total_items ASC
LIMIT 50;


