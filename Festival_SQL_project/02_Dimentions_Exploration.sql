/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Base_query
SELECT *
FROM consumer_behaviour;

-- Retrieve a list of unique state from which customers originate
SELECT DISTINCT
		state
FROM consumer_behaviour
ORDER by state;

-- Retrieve a list of unique sale_event, platform, and city_tier,state
SELECT DISTINCT
		sale_event,
		platform,
		city_tier,
		state
FROM consumer_behaviour
ORDER by
		sale_event,
		platform,
		city_tier,
		state;

select distinct 
		state,
		city_tier
from consumer_behaviour
order by 	
		city_tier ASC;

