*Group_concat as in MySQL is not available in SQL Server up to the current version

/*

Table 
Name     Sex     Role

Bob      M       Developer
Bob      M       Janitor
Joe      M       QA
Joe      M       CEO

Desired Output: 
Name     Role
Bob      Developer, Janitor
Joe      QA, CEO

*/

SELECT name, LEFT(roles , LEN(roles )-1) AS roles
FROM employee AS extern
CROSS APPLY
(
    SELECT role + ','
    FROM employee AS intern
    WHERE extern.name = intern.name
    FOR XML PATH('')
) pre_trimmed (roles)
GROUP BY name, roles;
