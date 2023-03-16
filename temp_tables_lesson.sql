show databases;

# use your database since it has write permissions 
use bayes_811; -- your format is pagel_####
select database();


# create a temporary table called my_numbers
# with two columns - n & name 

create temporary table my_numbers -- my_numbers is my new table name
	(
    n int unsigned not null, -- first column
    name varchar(20) not null  -- second column
    ) -- contained in parenthesis
;

-- view table that i created 
select * from my_numbers;

show tables; -- temp tables wont show up in your list of tables


# insert data in my_numbers

INSERT INTO my_numbers (n, name) -- table name (columns)
VALUES (1,'a'), (2,'b'), (3,'c'),(4,'d') -- inserting each column by row
;


# verify data was inserted
select * from my_numbers;


-- add in more data
INSERT INTO my_numbers (n, name) -- table name (columns)
VALUES (1,'a'), (2,'b'), (3,'c'),(4,'d'),(5,'a') -- inserting each column by row
;

select * from my_numbers;

# update values in temp table

UPDATE my_numbers -- stating that im going to UPDATE my_numbers table
set name = 'BIG' -- WHAT i want to change my values to
where n >= 4 -- WHERE i want to change my values
;

select * from my_numbers;


# delete values from temp table

DELETE FROM my_numbers -- telling it to DELETE from my_numbers table
where n = 2 -- what to delete
;

select * from my_numbers;


# -----------------------------------------------------
# switching to the employees database to create new temp table
use employees;


# find all current employees in customer service
# include their current salary

select 
	employees.*
    , salary
    , dept_name
from employees
	join dept_emp
		using (emp_no)
	join salaries
		using (emp_no)
	join departments
		using (dept_no)
where salaries.to_date > now()
	and dept_emp.to_date > now()
    and dept_name = 'Customer Service'
;



# create a temporary table from the above query

create temporary table bayes_811.curr_employees -- write to my current database
	( -- same setup as our initial temp table, but with our query in the parenthesis
	select
    	employees.*
		, salary
		, dept_name
	from employees
		join dept_emp
			using (emp_no)
		join salaries
			using (emp_no)
		join departments
			using (dept_no)
	where salaries.to_date > now()
		and dept_emp.to_date > now()
		and dept_name = 'Customer Service'
    )
;

select database();

select * from bayes_811.curr_employees; -- have to specify my databse again since im still in employees

select * from chipotle.orders; -- can display tables from other databases


-- switch back to my database & verify temp tables
use bayes_811;
show tables;

select * from curr_employees;


-- What is the average salary for current employees in Customer service
select avg(salary)
from curr_employees 
; -- i dont have to recreate the big query because i have it saved as a temp table



-- Add a new column for avg salary in temp table

ALTER TABLE curr_employees -- altering our table curr_employees
add avg_dept_salary float -- adding column by specifying name and datatype
;

select * from curr_employees;


-- update the average salary
select avg(salary)
from curr_employees; 


UPDATE curr_employees
SET avg_dept_salary = (select avg(salary) from curr_employees) 
-- cant call the temp table when im trying to change it
; -- errors out

UPDATE curr_employees
SET avg_dept_salary = '67285.2302' -- have to hard code this value
;

select * from curr_employees;


-- delete table

select * from my_numbers;

DROP TABLE curr_employees;
DROP TABLE my_numbers;

select * from my_numbers;


# RECAP TEMP TABLES
-- can only write to YOUR database

-- CREATE TEMPORARY TABLE [new_table_name] 
-- option 1. create table from scratch with values and datatypes, then insert values
-- option 2. create table from another query

-- ALTER TABLE [table_name] -- changing the STRUCTURE of the table
-- ADD/DROP [column_name/ row condition]

-- UPDATE TABLE [table_name] -- changing the VALUES in our table
-- SET [column_name = value]
-- WHERE [conditional]

-- DROP TABLE [table_name]








