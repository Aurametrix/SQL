-- Get unique DEPARTMENT from employee table
select distinct DEPARTMENT from EMPLOYEE


-- Select first 3 characters of FIRST_NAME from EMPLOYEE

-- Oracle Equivalent of SQL Server SUBSTRING is SUBSTR, Query : select substr(FIRST_NAME,0,3) from employee

SQL Server Equivalent of Oracle SUBSTR is SUBSTRING, Query : select substring(FIRST_NAME,0,3) from employee

-- remove duplicates
SELECT DISTINCT CAST(start_date AS DATE) FROM table;

-- Pattern matching
Select * from Student where studentname like 'a%'
Select * from Student where studentname like 'ami_'


-- There are many ways to fetch first 5 characters of the string

Select SUBSTRING(StudentName,1,5) as studentname from student
Select RIGHT(Studentname,5) as studentname from student

-- To get all countries where customers locate as a comma-separated string, you use the GROUP_CONCAT function as follows:

SELECT 
    GROUP_CONCAT(country)
FROM
    customers;
