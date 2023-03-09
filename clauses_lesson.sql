# CLAUSES 

# WHERE
-- We'll be exploring different ways we can write conditions in our WHERE CLAUSE

-- Let's use the chipotle database

show databases;

use chipotle;
select database();

show tables;

select *
from orders;



# LIKE \ NOT LIKE

-- to find things that aren't an exact match, we can use LIKE 
-- with it's associated wildcard % 

-- where you put the % specifys where the wild values are
-- FORMAT: WHERE [column_name] LIKE %[value]%


-- find all the items that are bowls

-- what we already know
select * 
from orders
where item_name = 'Bowl'
;

-- with like and % 
select *
from orders
where item_name LIKE 'bowl%'
;

select *
from orders
where item_name LIKE '%bowl'
;

select DISTINCT item_name
from orders
where item_name = '%bowl%' -- nothing comes back because we have to use % with LIKE
;

select DISTINCT item_name
from orders
where item_name LIKE '%bowl%'
;

-- find all the items that contain chicken
select distinct item_name
from orders
where item_name like '%chicken%'
;

-- find all the items that do not contain chicken
select distinct item_name
from orders
where item_name NOT like '%chicken%'
;

# IN

-- will select multiple values in our conditional statement from one column_name
-- FORMAT: WHERE [column_name] IN ([value1],[value2],[value3])


-- find all the rows in orders 1 through 5

select *
from orders
WHERE order_id IN (1,2,3,4,5)
;

-- find all rows that have chicken bowl or veggie bowl
select *
from orders
where item_name IN ('Chicken Bowl', 'Veggie Bowl')
;

select distinct item_name 
from orders
where item_name = ('Chicken Bowl', 'Veggie Bowl') -- equals multiple values errors out
;


select distinct item_name -- isolating the unique item_names
from orders
where item_name IN ('Chicken Bowl', 'Veggie Bowl')
;




# NULL / NOT NULL 

-- this allows to filter on our NULL values
-- NULL will be our value in the conditional statement
-- FORMAT: WHERE [column_name] IS [NOT] NULL 

-- lets move to the join_example database
show databases;
use join_example_db;
select database();
show tables;

-- find all users in the user table that don't have role_ids
select *
from users
where role_id IS NULL
;

-- find all users in the user table that do have role_ids
select *
from users
where role_id IS NOT NULL
;

# CHAINING 

-- we can chain our conditional statements in the WHERE CLAUSE
-- to check for more than one condition
-- using AND / OR 
-- FORMAT: WHERE [column_name1] operator [value1] 
-- 			AND/OR [column_name2] operator [value2]

-- have to write the complete conditional statement twice


-- find all users who have a role_id of 3 and are named sally
select *
from users
where role_id = 3
	and name = 'sally'
;

-- find all users who have a role_id of 3 and are named jane
select *
from users
where role_id = 3
	AND name = 'jane' -- use this when both condition is TRUE
;

select *
from users
where role_id = 3
	OR name = 'jane' -- use this when either condition is TRUE
;

-- AND will return the rows that meet BOTH conditions
-- OR will return the rows that meet EITHER conditions



-- find all users who have a role id of 1 or 3
select *
from users
where role_id = 1 or 3
; -- each conditional statement must have a column name

select *
from users
where 3
; -- a constant (not 0) returns everything because its saying where TRUE


select *
from users
where role_id = 1 
OR role_id = 3
;

select *
from users
where role_id IN (1,3)
; -- either one of these options work


# ORDER BY

-- lets us sort our table by specified column name
-- FORMAT: ORDER BY [column_name] [ASC/DESC]

-- 1. SELECT 
-- 2. FROM 
-- 3. WHERE
-- 4. ORDER BY

-- lets go back to the chipotle database
use chipotle;
select database();
show tables;


-- find all the bowls that have a quantity greater than 1
-- sort them from highest quanity to lowest quantity

select *
from orders
where item_name like '%bowl%'
	AND quantity > 1
ORDER BY quantity DESC
;

-- find all the bowls that have a quantity greater than 1
-- sort them from highest quanity to lowest quantity
-- and then sort them alphabetically by item_name

select *
from orders
where item_name like '%bowl%'
	AND quantity > 1
ORDER BY quantity DESC, item_name
;

select quantity, item_name
from orders
where item_name like '%bowl%'
	AND quantity > 1
ORDER BY quantity DESC, item_name DESC
;


# LIMIT

-- sets how many results are returned 
-- FORMAT: LIMIT [#]

-- 1. SELECT 
-- 2. FROM 
-- 3. WHERE
-- 4. ORDER BY
-- 5. LIMIT 

-- from all the orders in the orders table,
-- return only the top five results
select *
from orders
LIMIT 5
;

# OFFSET

-- use with LIMIT, tell it it skip a number of lines
-- FORMAT: LIMIT [#] OFFSET [#]

-- from all the orders in the orders table,
-- return only the top five results
-- but skip the first ten results

select *
from orders
limit 5 OFFSET 10
;


-- any 5 results
-- ORDER BY RAND()
select *
from orders
order by rand()
limit 5
;





