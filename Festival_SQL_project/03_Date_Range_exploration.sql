/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/
--Base_query

SELECT  *
FROM consumer_behaviour;

select count(distinct age)
from consumer_behaviour
where age is null;

-- Find the youngest and oldest customer based on age
SELECT MIN(age)as youngest_member,
		MAX(age)as oldest_member
FROM consumer_behaviour
WHERE age is not null;

select count( purchase_timestamp)
FROM consumer_behaviour
where purchase_timestamp is not null;

select distinct (purchase_timestamp),
	purchase_timestamp::DATE AS purchase_date,
	purchase_timestamp::TIME AS purchase_time
from consumer_behaviour
order by purchase_date asc;

-- Determine the first and last order date and the total duration in months

SELECT 
		MIN(purchase_date)as first_order_date,
		MAX(purchase_date)as last_order_date,
		FROM	consumer_behaviour;