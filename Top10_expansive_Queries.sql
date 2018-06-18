SELECT TOP 10
              SUBSTRING(dest.text, (deqs.statement_start_offset / 2) + 1,
                             ((CASE WHEN deqs.statement_end_offset = -1
                                          THEN DATALENGTH(dest.text)
                                          ELSE deqs.statement_end_offset
                                  END) - deqs.statement_start_offset) / 2 + 1) AS StatementText,
              deqs.execution_count,
              deqs.total_elapsed_time,
              deqs.total_logical_reads,
              deqs.total_logical_writes,
              deqs.total_worker_time,
              deqp.query_plan
FROM   sys.dm_exec_query_stats AS deqs
              CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest
              CROSS APPLY sys.dm_exec_query_plan(deqs.plan_handle) AS deqp
ORDER BY deqs.total_elapsed_time DESC;
