/*To create a database
CREATE DATABASE library;
*/

/*To create a table 
specify a name for the table column
and its data type */

CREATE TABLE myLibrary (all_my_nooks VARCHAR(4000));

---- The column all_my_books is defined as a character data type
---- It can hold as many as 4,000 characters

/* another example
CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);
the PersonID column will hold an integer
the Persons table will have 5 columns 
*/


/*
Drop the existing one before creating
*/

DROP TABLE myLibrary;

CREATE TABLE myLibrary (
title           VARCHAR(100)
, author        VARCHAR(100)
, author2       VARCHAR(100)
, publisher     VARCHAR(100)
, pages         INTEGER
, publish_date  VARCHAR(100)
, isbn          VARCHAR(100)
, book_language VARCHAR(100)
)

/*   A single column became eight columns with an opportunity to add a ninth by splitting 
the authors’ first and last names into separate columns (this is part of the data 
modeling process). */