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


/* specify what table and what column */
SELECT all_my_books FROM myLibrary;

/* select each name only once */
SELECT DISTINCT name FROM table_name;
