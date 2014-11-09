/*
JOIN allows to “lookup” records on other table based on the given conditions between two tables. 
UNION operation allows to add 2 similar data sets to create resulting data set that contains all the data from the source data sets. 
Union does not require any condition for joining. 
*/

SELECT * FROM EMP1
UNION
SELECT * FROM EMP2;

/* UNION returns unique records, UNION ALL includes duplicates * / 
SELECT * FROM EMPLOYEE WHERE ID = 5
UNION ALL
SELECT * FROM EMPLOYEE WHERE ID = 5
