
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
-- and order your results returned by first name. In your comments, answer: 
-- What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?

select * 
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by first_name ASC
;


-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
-- and order your results returned by first name and then last name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?

select * 
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by first_name ASC, last_name
;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
-- and order your results returned by last name and then first name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?

select * 
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by last_name, first_name
;

-- Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their employee number. Enter a comment with the number of employees returned, 
-- the first employee number and their first and last name, 
-- and the last employee number with their first and last name.

select *
from employees
where last_name like 'e%e'
order by emp_no
;

-- Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned, the name of the newest employee, 
-- and the name of the oldest employee.

select *
from employees
where last_name like 'e%e'
order by hire_date DESC
;

-- Find all employees hired in the 90s and born on Christmas. 
-- Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned, 
-- the name of the oldest employee who was hired last, 
-- and the name of the youngest employee who was hired first.

select *
from employees
where birth_date like '%12-25'
	and hire_date like '199%'
order by birth_date, hire_date DESC
;


