 /*!  

T-SQL version of BubbleSort - just as an exercise as is absolutely impractical
In real life - ran through query analyser and:
SELECT * FROM #foo ORDER BY [value]

*/



IF OBJECT_ID('tempdb..#foo') IS NOT NULL DROP TABLE #foo
IF OBJECT_ID('bubbleSort') IS NOT NULL DROP PROCEDURE bubbleSort
GO

CREATE TABLE #foo (
	[position] INT IDENTITY (1,1)
	, [value] INT
	)
GO

-- Populate the table
INSERT #foo SELECT CAST(CAST(NEWID() AS VARBINARY) AS INT)
GO 50

-- Make some gaps in the identity column
DELETE f FROM #foo f JOIN (SELECT TOP 10 [position] FROM #foo ORDER BY NEWID()) a ON a.[position] = f.[position]

-- Show #foo ordered by identity
SELECT * FROM #foo ORDER BY [position] ASC

-- Show #foo ordered by value (this should be the same as the bubble sort)
SELECT * FROM #foo ORDER BY [value] ASC
GO


-- Procedure to sort
CREATE PROCEDURE bubbleSort AS BEGIN

	SET NOCOUNT ON
	CREATE TABLE #t (
		[order] INT
		, [value] INT
		)

	DECLARE
		@swapped BIT
		, @counter INT
		, @topVal INT

	-- Populate #t
	INSERT INTO #t (
		[order]
		, [value]
		)
	SELECT
		ROW_NUMBER() OVER(ORDER BY [position] ASC)
		, [value]
	FROM
		#foo

	SELECT
		@swapped = 1
		, @counter = 1
		, @topVal = COUNT([order])
	FROM
		#t

	IF ( ISNULL(@topVal, -1) < 2 ) BEGIN
		PRINT 'No data'
		SELECT * FROM #t
		RETURN
	END

	WHILE (@swapped = 1) BEGIN

		SET @counter = 1
		SET @swapped = 0

		WHILE (@counter < @topVal) BEGIN
		
			IF ((SELECT [value] FROM #t WHERE [order] = @counter) > (SELECT [value] FROM #t WHERE [order] = @counter + 1)) BEGIN
				UPDATE #t SET [order] = -1 WHERE [order] = @counter + 1
				UPDATE #t SET [order] = @counter + 1 WHERE [order] = @counter
				UPDATE #t SET [order] = @counter WHERE [order] = -1
				SET @swapped = 1
			END
		
			SET @counter = @counter + 1
		END
	END

	SELECT * FROM #t ORDER BY [order]
END
GO

-- Use the bubble sort
EXEC bubbleSort
