* ref_num   name      type       route
* ----------------------------------------
* 1         A         W          401
* 2         B         X          401
* 3         C         E          401
* 3         C         E          411
* 4         D         Z          401
* 5         K         W          701
* 5         K         W          991
* 5         K         W          556
* 5         K         W          401
* 6         L         X          401
* 7         D         Y          401
* 7         D         Y          411
* 7         D         Y          680
* 8         E         Z          401
*
*
* ref_num   name      type       routes
* ----------------------------------------
* 1         A         W          401
* 2         B         X          401
* 3         C         E          401,411
* 4         D         Z          401
* 5         K         W          701,991,556,401
* 6         L         X          401
* 7         D         Y          401,411,680
* 8         E         Z          401



SELECT ref_num, name, type, GROUP_CONCAT(routes SEPARATOR ', ')   
FROM Table 
GROUP BY ref_num, name, type



* in Oracle use WM_CONCAT
*
* SELECT REF_NUM, NAME, TYPE, WM_CONCAT(ROUTE) 
* FROM ROUTES
* GROUP BY REF_NUM, NAME, TYPE;
