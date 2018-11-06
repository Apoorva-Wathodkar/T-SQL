/* This query should be used to reset the database authorization error - 
This happens when the database owner SID recorded in the master database differs from the database owner SID recorded in database 

Error thrown by SQL Server in this case looks like - 
Error Executing Query : The database owner SID recorded in the master database differs from the database owner SID recorded 
in database 'XXXXXXXX'. You should correct this situation by resetting the owner of database 'XXXXXXXX' 
using the ALTER AUTHORIZATION statement. 
 
Solution - 
Run this script on the Database for which we are getting this error

*/


DECLARE @Command VARCHAR(MAX) = 'ALTER AUTHORIZATION ON DATABASE::[<<DatabaseName>>] TO 
[<<LoginName>>]' 

SELECT @Command = REPLACE(REPLACE(@Command 
            , '<<DatabaseName>>', SD.Name)
            , '<<LoginName>>', SL.Name)
FROM master..sysdatabases SD 
JOIN master..syslogins SL ON  SD.SID = SL.SID
WHERE  SD.Name = DB_NAME()

PRINT @Command
EXEC(@Command)
