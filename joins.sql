/* 
Joins:
Assume we have Table A is on the left & Table B is on the right:

Table A       Table B
id name       id  name
-- ----       --  ----
1  Pirate     1   Rutabaga
2  Monkey     2   Pirate
3  Ninja      3   Darth Vader
4  Spaghetti  4   Ninja

*/


---- inner join


SELECT * FROM TableA
INNER JOIN TableB
ON TableA.name = TableB.name

/* 
id  name       id   name
--  ----       --   ----
1   Pirate     2    Pirate
3   Ninja      4    Ninja


For tables a and b with just one column:
select * from a INNER JOIN b on a.a = b.b;
select a.*,b.*  from a,b where a.a = b.b;

*/

---- Inner join produces only the set of records that match in both Table A and Table B.
---- It gives the intersection of the two tables: the two rows they have in common.


/* 
Full outer join produces the set of all records in Table A and Table B, with matching 
records from both sides. If no match, the missing side will contain null.
*/

SELECT * FROM TableA
FULL OUTER JOIN TableB
ON TableA.name = TableB.name

/* 

id    name       id    name
--    ----       --    ----
1     Pirate     2     Pirate
2     Monkey     null  null
3     Ninja      4     Ninja
4     Spaghetti  null  null
null  null       1     Rutabaga
null  null       3     Darth Vader

OR:
select * from a FULL OUTER JOIN b on a.a = b.b;

*/

---- A full outer join will give the union of A and B

/* 
Left outer join produces a complete set of records from Table A, with the matching records 
(where available) in Table B. If there is no match, the right side will contain null.
*/



SELECT * FROM TableA
LEFT OUTER JOIN TableB
ON TableA.name = TableB.name

/* 
id  name       id    name
--  ----       --    ----
1   Pirate     2     Pirate
2   Monkey     null  null
3   Ninja      4     Ninja
4   Spaghetti  null  null

OR:
select * from a LEFT OUTER JOIN b on a.a = b.b;
select a.*,b.*  from a,b where a.a = b.b(+);

*/

---- A left outer join will give all rows in A, plus any common rows in B.
