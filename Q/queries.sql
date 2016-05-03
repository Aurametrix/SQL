-- Get unique DEPARTMENT from employee table
select distinct DEPARTMENT from EMPLOYEE


-- Select first 3 characters of FIRST_NAME from EMPLOYEE

-- Oracle Equivalent of SQL Server SUBSTRING is SUBSTR, Query : select substr(FIRST_NAME,0,3) from employee

SQL Server Equivalent of Oracle SUBSTR is SUBSTRING, Query : select substring(FIRST_NAME,0,3) from employee

-- remove duplicates
SELECT DISTINCT CAST(start_date AS DATE) FROM table;
