/* 

one line of code that will update all the statistics in the database 
using the default sample size of 20,000 rows per table.

EXEC sp_updatestats

*/


/*

The other way, is to use the The other way, is to use the UPDATE_STATISTICS command 
that gives much better granularity of control

It's used when a large processing of data has occurred. 
If a large amount of deletions any modification or Bulk Copy into the tables has occurred, 
it has to update the indexes to take these changes into account. 
UPDATE_STATISTICS updates the indexes on these tables accordingly.

*/
-- Update all statistics on a table
UPDATE STATISTICS Sales.SalesOrderDetail

-- Update a specific index on a table
UPDATE STATISTICS Sales.SalesOrderDetail IX_SalesOrderDetail

-- Update one column on a table specifying sample size
UPDATE STATISTICS Production.Product(Products) WITH SAMPLE 50 PERCENT

/*
update all out of date statustucs 
*/

DECLARE @MaxDaysOld INT
DECLARE @SamplePercent INT
DECLARE @SampleType nvarchar(50)

SET @MaxDaysOld = 0
SET @SamplePercent = NULL --25
SET @SampleType = 'PERCENT' --'ROWS'

BEGIN TRY
DROP TABLE #OldStats
END TRY
BEGIN CATCH SELECT 1 END CATCH

SELECT
RowNum = ROW_NUMBER() OVER (ORDER BY ISNULL(STATS_DATE(object_id, st.stats_id),1))
,TableName = OBJECT_SCHEMA_NAME(st.object_id) + '.' + OBJECT_NAME(st.object_id)
,StatName = st.name
,StatDate = ISNULL(STATS_DATE(object_id, st.stats_id),1)
INTO #OldStats
FROM sys.stats st WITH (nolock)
WHERE DATEDIFF(DAY, ISNULL(STATS_DATE(object_id, st.stats_id),1), GETDATE()) > @MaxDaysOld
ORDER BY ROW_NUMBER() OVER (ORDER BY ISNULL(STATS_DATE(object_id, st.stats_id),1))

DECLARE @MaxRecord INT
DECLARE @CurrentRecord INT
DECLARE @TableName nvarchar(255)
DECLARE @StatName nvarchar(255)
DECLARE @SQL nvarchar(MAX)
DECLARE @SampleSize nvarchar(100)

SET @MaxRecord = (SELECT MAX(RowNum) FROM #OldStats)
SET @CurrentRecord = 1
SET @SQL = ''
SET @SampleSize = ISNULL(' WITH SAMPLE ' + CAST(@SamplePercent AS nvarchar(20)) + ' ' + @SampleType,N'')

WHILE @CurrentRecord <= @MaxRecord
BEGIN

SELECT
@TableName = os.TableName
,@StatName = os.StatName
FROM #OldStats os
WHERE RowNum = @CurrentRecord

SET @SQL = N'UPDATE STATISTICS ' + @TableName + ' ' + @StatName + @SampleSize

PRINT @SQL

EXEC sp_executesql @SQL

SET @CurrentRecord = @CurrentRecord + 1

END
