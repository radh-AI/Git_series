/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/
/*Segment products into cost ranges and 
count how many products fall into each segment*/
WITH category_segment as(
	SELECT category_browsed,
			price_final,
		CASE
		WHEN price_final < 100 THEN 'Below 100'
            WHEN price_final BETWEEN 100 AND 500 THEN '100-500'
            WHEN price_final BETWEEN 500 AND 1000 THEN '500-1000'
            ELSE 'Above 1000'
        END AS price_range
	FROM consumer_behaviour		
)
	SELECT 
			price_range,
			count(category_browsed)as total_products
	from category_segment
	group by price_range
	order by total_products desc;

/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/
WITH customer_spending as(
	select 
		customer_id,
		membership_tier,
		sum(amount_spent)as total_spending,
		min(purchase_date)as first_order,
		max(purchase_date)as last_order
	from consumer_behaviour
	where amount_spent is not null
	group by customer_id,membership_tier
)
SELECT customer_segment,
		count(customer_id)as total_customers
FROM (
		select customer_id,
		membership_tier,
		case
		when membership_tier = 'Prime' and total_spending > 5000 then 'VIP'
		when membership_tier =  'Plus' and total_spending <5000 then 'Regular'
		else 'New'
		end as customer_segment
		from customer_spending)as segmented_customers
		group by customer_segment
		order by total_customers DESC;
