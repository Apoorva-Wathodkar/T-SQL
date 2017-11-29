/*Query to find out all the tables for which partition is enabled*/

USE AdventureWorksDW

SELECT DISTINCT
    T.name as TableName
FROM sys.partitions as P
    JOIN sys.tables as T
        ON P.object_id = T.object_id
WHERE P.partition_number <> 1