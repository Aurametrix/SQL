/* to select 5 records form a table */

/* In Oracle:
SELECT * 
FROM Persons
WHERE ROWNUM <= 5;
In SQL Server,
*/

SELECT TOP 5 * FROM Persons;

/*
SELECT  LastName 
FROM PersonID o
WHERE (SELECT count(*) FROM EMPLOYEE i WHERE i.name < o.name) < 5
*/