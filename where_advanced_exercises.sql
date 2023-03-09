use employees;
select database();
show tables;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
-- What is the employee number of the top three results?

select * 
from employees
where first_name in ('Irena', 'Vidya','Maya')
;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, 
-- but use OR instead of IN. What is the employee number of the top three results? 
-- Does it match the previous question?

select *
from employees
where first_name = 'Irena'
	or first_name = 'Vidya'
    or first_name = 'Maya'
;


select distinct first_name
from employees
where first_name = 'Irena'
	or first_name = 'Vidya'
    or first_name = 'Maya'
; -- to check that im only bringing back these names


-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, 
-- and who is male. 
-- What is the employee number of the top three results.

select *
from employees
where (first_name = 'Irena'
	or first_name = 'Vidya'
    or first_name = 'Maya')
    and gender = 'M'
;

-- Find all unique last names that start with 'E'.
select distinct last_name
from employees
where last_name like 'e%'
;

-- Find all unique last names that start or end with 'E'.
select distinct last_name
from employees
where last_name like 'e%'
	OR last_name like '%e'
;

-- Find all unique last names that end with E, but does not start with E?
select distinct last_name
from employees
where last_name NOT like 'e%'
	AND last_name like '%e'
;

-- Find all unique last names that start and end with 'E'.
select distinct last_name
from employees
where last_name like 'e%e'
;

-- Find all current or previous employees hired in the 90s. 
-- Enter a comment with top three employee numbers.
select *
from employees
where hire_date like '199%'
;

select *
from employees
where hire_date between '1990-01-01' and '1999-12-31'
;

-- Find all current or previous employees born on Christmas. 
-- Enter a comment with top three employee numbers.
select *
from employees
where birth_date like '%12-25'
;

-- Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with top three employee numbers.
select *
from employees
where birth_date like '%12-25'
	and hire_date like '199%'
;

-- Find all unique last names that have a 'q' in their last name.
select distinct last_name
from employees
where last_name like '%q%'
;


-- Find all unique last names that have a 'q' in their last name but not 'qu'.
select distinct last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
;
