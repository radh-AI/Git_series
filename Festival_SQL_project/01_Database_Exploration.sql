-- Retrieve a list of all tables in the database
SELECT 
	Table_Catalog,
	Table_Schema,
	Table_Name,
	Table_Type
FROM information_schema."tables";

-- Retrieve all columns for a specific table (consumer_behaviour)
SELECT
	column_name,
	Data_type,
	IS_Nullable,
	Character_maximum_length
from information_schema."columns"
WHERE	Table_name = 'consumer_behaviour';