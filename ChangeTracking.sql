/* Get all the tables having change tracking enabled on the database */

SELECT 
  s.name as Schema_name, 
  t.name AS Table_name, 
  tr.*
FROM sys.change_tracking_tables tr
INNER JOIN sys.tables t on t.object_id = tr.object_id
INNER JOIN sys.schemas s on s.schema_id = t.schema_id
