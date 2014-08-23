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

/*  In Access
One of the values you can specify for each relationship is the join type. 
(On the Design tab, in the Tools group, click Edit Relationships.)
The join type tells Access which records to include in a query result.
inner join is default (option "1"):
"only include rows where the joined fields from both tables are equal"

Left outer join is option "2"
include all records from "1st table .." and only those from ..2nd table" where 
the joined fields are equal

Right outer join is option "3"
include all records from ..2nd tbl"  and only those from "1st tbl" where 
the joined fields are equal
*/

---- MySQL doesn't have FULL Outer join:

SELECT * FROM TableA A
LEFT JOIN TableB B ON A.name = B.name
UNION
SELECT * FROM TableA A
RIGHT JOIN TableB B ON A.name = B.name

---- for improved performance, use UNION
SELECT TableA.*, TableB.* 
FROM 
  TableA LEFT OUTER JOIN TableB
    ON TableA.name = TableB.name

UNION ALL

SELECT TableA.*, TableB.*
FROM 
  TableA RIGHT OUTER JOIN TableB
    ON TableA.name = TableB.name
WHERE 
    TableA.name IS NULL ;


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



/* 
Cross join joins everything to everything
*/

SELECT * FROM TableA
CROSS JOIN TableB
