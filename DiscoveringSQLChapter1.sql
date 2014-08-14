/*** Discovering SQL. Chapter 1 SQL scripts *******************************************/
/*** all right reserved (c) agilitator.com ********************************************/ 

CREATE TABLE myLibrary (all_my_books VARCHAR(4000));

----------------------------------------------------------------
-- remove the existing table from the database before creating
-- a new table with the same name
----------------------------------------------------------------
DROP TABLE myLibrary;

CREATE TABLE myLibrary
(
     title         	VARCHAR(100)
   , author        	VARCHAR(100)
   , author2       	VARCHAR(100)
   , publisher     	VARCHAR(100)
   , pages         	INTEGER
   , publish_date  	VARCHAR(100)
   , isbn          	VARCHAR(100)
   , book_language 	VARCHAR(100)
);

---------------------------------------------------------------
INSERT INTO myLibrary VALUES (
    'SQL Bible'
   ,'Alex Kriegel'
   ,'Boris M. Trukhnov' 
   ,'Wiley'
   ,888 
   ,'April 7,2008'
   ,'978-0470229064'
   ,'English');

INSERT INTO myLibrary (
     title
   , author
   , book_language
   , publisher
   , pages
   , author2
   , publish_date
   , isbn
)VALUES (
    'SQL Bible'
   ,'Alex Kriegel'
   ,'English'
   ,'Wiley'
   ,888 
   ,'Boris M. Trukhnov' 
   ,'April 7,2008' 
   ,'978-0470229064');

---------------------------------------------------------------------------------
INSERT INTO myLibrary(title, author, book_language, publisher, pages, publish_date, isbn) VALUES ('Microsoft SQL Server 2000 Weekend Crash Course','Alex Kriegel' ,'English','Wiley',408, 'October 15, 2001','978-0764548406');

INSERT INTO myLibrary(title, author, book_language, publisher, pages, publish_date, isbn) VALUES ('Mindswap','Robert Sheckley' ,'English','Orb Books',224,'May 30, 2006','978-0765315601');

INSERT INTO myLibrary(title, author, book_language, publisher, pages, publish_date, isbn) VALUES ('Jonathan Livingston Seagull','Richard Bach' ,'English','MacMillan',100, '1972','978-0075119616');

INSERT INTO myLibrary(title, author, book_language, publisher, pages, publish_date, isbn) VALUES ('A Short History of Nearly Everything','Bill Bryson' ,'English','Broadway',624, 'October 5, 2010','978-0307885159');

------------------------------------------------------------------------------------------------
SELECT  title
      , author
      , author2
      , publisher
      , pages
      , publish_date
      , isbn
      , book_language
FROM myLibrary;

------------------------------------------------------------------------------------------------

SELECT * FROM myLibrary;
------------------------------------------------------------------------------------------------

SELECT  title
      , author
      , author2
FROM myLibrary;
------------------------------------------------------------------------------------------------

SELECT * FROM myLibrary WHERE publisher = 'Wiley';
SELECT * FROM myLibrary WHERE publisher <>'Wiley';
SELECT * FROM myLibrary 
    WHERE publisher = 'Wiley' AND author= 'Alex Kriegel';

DELETE FROM myLibrary;

DELETE FROM myLibrary 
    WHERE publisher = 'Wiley';

DELETE FROM myLibrary 
    WHERE publisher = 'Wiley' AND pages = 888;

DELETE FROM myLibrary 
    WHERE isbn='978-0470229064';

UPDATE myLibrary SET pages = 500;

UPDATE myLibrary SET pages = 500
    WHERE isbn='978-0470229064';

UPDATE myLibrary SET 
    pages = 500
  , title = 'SQL Bible, 2nd Edition'
         WHERE isbn='978-0470229064';

UPDATE myLibrary SET title = 'SQL Bible, 2nd Edition'
         WHERE title = 'SQL Bible';

UPDATE myLibrary SET title = title + ', 2nd Edition'
         WHERE title = 'SQL Bible';



