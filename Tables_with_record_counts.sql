/*Query to find out all the tables with record counts*/

USE AdventureWorksDW

SELECT DISTINCT
    t.name AS TableName,
    i.rows AS RecordCnt
FROM sysindexes i
    INNER JOIN sys.tables t
        ON i.id = t.OBJECT_ID
WHERE t.is_ms_shipped = 0
ORDER BY t.name