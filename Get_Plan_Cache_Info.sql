/*
Following query can be executed to find out the details about the plan cache
*/

SELECT  qs.execution_count
       ,s.text
       ,cp.size_in_bytes
       ,qs.query_hash
       ,qs.query_plan_hash
       ,qp.query_plan
       ,qs.plan_handle
FROM    sys.dm_exec_query_stats qs
        JOIN sys.dm_exec_cached_plans cp ON qs.plan_handle = cp.plan_handle
        CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
        CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) s
WHERE   s.text LIKE '%DimEmployee';

