USE AdventureWorksDW
/*
Following query can be executed to find out the basic details about the statistics of any object
replace the object name below in where clause to get the statistics of an object
*/

SELECT  sch.name + '.' + so.name AS 'Table'
       ,ss.name AS 'Statistic'
       ,ss.auto_created AS 'Is Auto Created'
       ,ss.user_created AS 'Is User Created'
       ,ss.has_filter AS 'Is Filtered'
       ,ss.filter_definition AS 'Filter Definition'
       ,sp.last_updated AS 'Stats Last Updated'
       ,sp.rows AS 'Rows in Table'
       ,sp.rows_sampled AS 'Rows Sampled'
       ,sp.unfiltered_rows AS 'Unfiltered Rows'
       ,sp.modification_counter AS 'Row Modifications'
       ,sp.steps AS 'Histogram Steps'
FROM    sys.stats ss
        JOIN sys.objects so ON ss.object_id = so.object_id
        JOIN sys.schemas sch ON so.schema_id = sch.schema_id
        CROSS APPLY sys.dm_db_stats_properties(so.object_id,
                                            ss.stats_id) AS sp
WHERE   so.object_id = OBJECT_ID('dbo.DimEmployee')
ORDER BY ss.user_created
       ,ss.auto_created
       ,ss.has_filter;