/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

--Base_query

SELECT *
from consumer_behaviour;

-- Find the Total Sales
SELECT SUM(amount_spent)as total_sales
FROM consumer_behaviour;

-- Find how many items are sold
SELECT SUM(items_purchased) AS total_quantity 
FROM consumer_behaviour;

-- Find the average selling price
select AVG(price_final)as avg_selling_price
FROM consumer_behaviour;

-- Find the Total number of Orders
select customer_id,
sum(distinct items_purchased)as total_orders
from consumer_behaviour
where customer_id is not null 
	and 
	items_purchased is not null
GROUP by customer_id
having	sum(items_purchased)>0;

-- Find the total number of category_browsed
select 
		count(distinct category_browsed)as total_category_browsed,
		category_browsed
FROM consumer_behaviour
where category_browsed is not null
Group by category_browsed;

-- Find the total number of customers
SELECT COUNT(customer_id) AS total_customers 
FROM consumer_behaviour;

-- Find the total number of customers that has placed an order
select count(Distinct customer_id)as total_customers_ordered,items_purchased
FROM consumer_behaviour
where items_purchased is not null
group by items_purchased
HAVING (items_purchased)>0
order by items_purchased ASC;

-- Generate a Report that shows all key metrics of the business
SELECT 'Total Customers' as measure_name,COUNT(customer_id) as measure_value FROM consumer_behaviour
UNION ALL 
SELECT	'Total Sales',SUM(amount_spent) FROM consumer_behaviour
UNION ALL
SELECT 'Total_Quantity',SUM(items_purchased)  FROM consumer_behaviour
UNION ALL 
select 'Avg_Selling_Price',AVG(price_final) FROM consumer_behaviour
UNION ALL 
select 'Total_Orders',sum(items_purchased) from consumer_behaviour
UNION ALL 
select 'Total_Category_Browsed',count(distinct category_browsed) FROM consumer_behaviour
UNION ALL	
SELECT 'Total_Customers_Ordered',count(Distinct customer_id)
FROM consumer_behaviour
where items_purchased is not null;







