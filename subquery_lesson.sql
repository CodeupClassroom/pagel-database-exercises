
/* A subquery is a SELECT statement within another statement */

# subquery scalar example:

-- Q: Which employees have higher than average salary?

use employees;


-- 1. inner query: what is the average salary?

select avg(salary)
from salaries;

-- 2. outer query: find all salaries

select *
from salaries;


-- 3. combine queries together


select *
from salaries
where salary > -- use any conditional operator
	( -- must put subquery in parenthesis
    select avg(salary)
	from salaries
    )
;
                    
-- Q extra: find the first and last names of the employees from the above query

select * from employees limit 10;

select
	first_name
    , last_name
    , salaries.* -- pulls back everything from the salary table
from salaries
	join employees -- added in join to pull back name
		using (emp_no)
where salary > -- use any conditional operator
	( -- must put subquery in parenthesis
    select avg(salary)
	from salaries
    )
;
                    
                    
-- Q: How do I add the average salary to my previous query?
-- A: A subquery in the select statement! 
                        
            
-- 1. inner query: average salary

select avg(salary) from salaries;


-- 2. outer query: previous query


select
	first_name
    , last_name
    , salaries.* -- pulls back everything from the salary table
from salaries
	join employees -- added in join to pull back name
		using (emp_no)
where salary > -- use any conditional operator
	( -- must put subquery in parenthesis
    select avg(salary)
	from salaries
    )
;


-- 3. combine


select
	first_name
    , last_name
    , salary
    , (select avg(salary) from salaries) as avg_salary -- subquery in select
    , 'hello' -- single values are repeated in each row
from salaries
	join employees -- added in join to pull back name
		using (emp_no)
where salary > -- use any conditional operator
	( -- must put subquery in parenthesis
    select avg(salary)
	from salaries
    )
;



# subquery column example:
--  Q: find all the current department managers names and birth dates

show tables;

select * from employees limit 10; -- looking at my tables
select * from dept_manager limit 10;

-- 1. inner query: find all current managers 

select *
from dept_manager
where to_date > now()
;

-- 2. outer query: find names and birth dates

select first_name, last_name, birth_date
from employees
;

-- 3. combine 

select first_name, last_name, birth_date
from employees
where emp_no in  -- make sure your variable matches the output of the inner query
	( 
    select emp_no -- both needed to say emp_no
	from dept_manager
	where to_date > now()
    ) -- wrapped in parenthesis
;


-- Q extra: add in which department each manager works in 

select * from departments limit 10;
select * from dept_manager limit 10;

select first_name, last_name, birth_date, dept_name
from employees
	join dept_manager
		using (emp_no)
	join departments
		using (dept_no)
where emp_no in  -- make sure your variable matches the output of the inner query
	( 
    select emp_no -- both needed to say emp_no
	from dept_manager
	where to_date > now()
    ) -- wrapped in parenthesis
;


-- extra: subquery in a subquery because extra
select first_name, last_name, birth_date, dept_name
from employees
	join dept_manager
		using (emp_no)
	join departments
		using (dept_no)
where emp_no in  -- make sure your variable matches the output of the inner query
	( 
    select emp_no -- both needed to say emp_no
	from dept_manager
	where to_date > (select avg(to_date) from dept_manager)
    ) -- wrapped in parenthesis
;

# subquery table example:

-- from groupby exercises
-- How many duplicate usernames are there from your username query?

select sum(cnt), count(cnt), max(cnt)  
from 
	( -- whenever you are returning a table, you have to put it in your from statement
	select 
		lower(
			concat(
				substr(first_name, 1, 1)
				,substr(last_name, 1, 4)
				, '_'
				,lpad(month(birth_date),2,0)
				,substr(birth_date, 3,2)
				)
			) as username
		, count(*) as cnt
		from employees
	group by username
	having count(*) >= 2
	order by count(*) desc
	) as un -- all derived tables must have a alias
