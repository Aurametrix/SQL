--Write an SQL Query to find names of employee start with ‘S’.

SELECT * FROM Employees WHERE EmpName like ‘S%’.

--Retrieve all records of employment 1 that should not be present n employment 2

Select * from employment 2)-(Select * from employment 1

--Use Query Analyzer to get the version of SQL server and operating system

SELECT SERVERPROPERTY ('productversion'), SERVERPROPERTY ('productlevel') and SERVERPROPERTY ('edition')

--Define a temp table

/*

a temporary storage structure, stores data temporarily to manipulate and change it before it reaches its destination format

In table_user.gender column change ‘male to female’ and ‘female to male’ in one SQL statement.
Note that UPDATE_STATISTICS command would give much better granularity of control

*/

UPDATE table_user

SET gender =

CASE gender

WHEN ‘male’ THEN ‘female’

WHEN ‘female’ THEN ‘male’

ELSE gender

END




