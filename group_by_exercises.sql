-- In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
select count(distinct title)
from titles
;

-- Write a query to to find a list of all unique last names of all employees 
-- that start and end with 'E' using GROUP BY.
select last_name
from employees
where last_name like 'e%e'
group by last_name
-- having last_name like 'e%e'
;

-- Write a query to to find all unique combinations of first and last names 
-- of all employees whose last names start and end with 'E'.
select first_name, last_name
from employees
where last_name like 'e%e'
group by first_name, last_name
;


-- Write a query to find the unique last names with a 'q' but not 'qu'. 
-- Include those names in a comment in your sql code.

select last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
group by last_name
;


-- Add a COUNT() to your results (the query above) to find the number of employees 
-- with the same last name.

select last_name, count(*)
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
group by last_name
;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya'. 
-- Use COUNT(*) and GROUP BY to find the number of employees 
-- for each gender with those names.

select first_name, gender, count(*)
from employees
where first_name IN ('Irena','Vidya','Maya')
group by first_name, gender
order by first_name
;

-- Using your query that generates a username for all of the employees, 
-- generate a count employees for each unique username.

select
	lower(concat(
    left(first_name, 1)
    ,left(last_name,4)
    ,'_'
    ,substr(birth_date,6,2)
    ,substr(birth_date,3,2)
    )) as username, count(*)
from employees
group by username
;


-- From your previous query, are there any duplicate usernames? 
-- What is the higest number of times a username shows up? 

select
	lower(concat(
    left(first_name, 1)
    ,left(last_name,4)
    ,'_'
    ,substr(birth_date,6,2)
    ,substr(birth_date,3,2)
    )) as username, count(*)
from employees
group by username
having count(*) > 1
order by count(*) DESC -- need to do this programmaticly if we've limiting our results in the GUI
;

-- Bonus: How many duplicate usernames are there from your previous query?


select count(*) 
from 
	(select
		lower(concat(
		left(first_name, 1)
		,left(last_name,4)
		,'_'
		,substr(birth_date,6,2)
		,substr(birth_date,3,2)
		)) as username, count(*)
	from employees
	group by username
	having count(*) > 1
	order by count(*) DESC) as derived_table_name
;


-- Determine the historic average salary for each employee. 
select emp_no, round(avg(salary),2)
from salaries
group by emp_no
;

-- Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.

select dept_no, count(distinct emp_no) as current_dept_emp
from dept_emp
where to_date > now()
group by dept_no 
;

-- Determine how many different salaries each employee has had. 
-- This includes both historic and current.
select emp_no, count(*)
from salaries
group by emp_no
order by count(*) desc
;

-- Find the maximum salary for each employee.
select emp_no, max(salary)
from salaries
group by emp_no
;


-- Find the minimum salary for each employee.
select emp_no, min(salary)
from salaries
group by emp_no
;

-- Find the standard deviation of salaries for each employee.
select emp_no, round(std(salary),1), round(stddev(salary),1), count(*)
from salaries
group by emp_no
;

-- Now find the max salary for each employee where that max salary is greater than $150,000.
select emp_no, max(salary) as max_sal
from salaries
group by emp_no
having max_sal > 150000
;

-- Find the average salary for each employee where that average salary is between $80k and $90k.
select emp_no, round(avg(salary),2) as avg_sal
from salaries
group by emp_no
having avg_sal BETWEEN 80000 and 90000
;
