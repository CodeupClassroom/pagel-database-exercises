# Basic Statments

-- We're talking about the first 3 major parts of a SQL QUERY

-- 1 SELECT [the columns that we want]
-- 2 FROM [where we are getting the data from (the table)]
-- 3 WHERE [how to filter that data]

-- We can utilize the SELECT statment stand-alone
-- FORMAT: SELECT [what]

select 'hello world';

-- 'hello world'

select 2+2;


-- To pull back data from the database, we have to incorporate our 
-- FROM statement  

-- Let's pull back data from the fruits database

-- 1. select the fruits database using the correct name
-- 2. find out the name of the tables in the fruits database
-- 3. write a query to pull back data from table

show databases;

use fruits_db;

select database();

show tables;


-- We are going to write a query that says "select all of the data from the fruits table" 
-- To pull back ALL data from a table, use the the wildcard: *
-- FORMAT: SELECT * FROM [table]

select 

* 
from					 fruits
           ; -- white space doesnt matter in sql

select * from fruits; -- one line version

select *
from fruits
;


-- What if we wanted only the id and name column?
-- To select only certain rows, enter the names in the select statement
-- FORMAT: SELECT column_name1, column_name2 FROM [table]

select id, name 
from fruits;



-- What if only wanted the rows with apple in the name? 

-- To filter rows, we need to use the WHERE clause
-- FORMAT: SELECT * FROM [table] WHERE [condition]


-- condition FORMAT: [column_name] operator [value] 
-- the condition in this example: name = 'apple'

select *
from fruits
where name    =      ' apple'; -- whats in quotes is taken literally aka accounts for whitespace

select quantity, name, id -- order of columns doesnt matter in select statment
from fruits
where name = 'apple';


-- NOTICE THE ORDER OF STATEMENTS
-- MUST MAINTAIN ORDER IN SQL

-- 1 SELECT 
-- 2 FROM 
-- 3 WHERE

select *
where name = 'apple'
from fruits; -- this errors out because the statements are out of order



-- Many operators can be used in the WHERE condition
-- =, !=, <>, <, >, <=, >=
-- BETWEEN  


select * 
from fruits
where name <> 'apple'; -- does not equal condition

-- Give me fruits that have quanties greater than 10

select *
from fruits
where quantity > 10
;

-- Only return the names from the previous query

select name
from fruits
where quantity > 10
;


-- Give me fruits that have ids between 2 and 5
-- condition FORMAT: [column_name] BETWEEN [value1] and [value2]

select *
from fruits
where id between 2 and 5;

-- NOTICE: between is including both the 2 and the 5 in the results
-- this means the between is INCLUSIVE

-- what if i wanted to rename a column
-- use an ALIAS
-- FORMAT: [old_column_name] AS [new_column_name]

select id as inx, name as fruit_name, quantity as inventory
from fruits
where id between 2 and 5;


-- in the numbers database in the numbers2 table, what categories are available? 

use numbers;
select database();
show tables;

select * from numbers2;


-- to see only unique values, use DISTINCT in the SELECT statment
-- FORMAT: SELECT DISTINCT [column_name]

select distinct category, n
from numbers2;


# RECAP









-- show me categories for only supergroup one and rename 
-- 1. write base query: SELECT * FROM [table]
-- 2. filter data: add WHERE
-- 3. specify columns to keep: SELECT [column_name], [column_name]

















