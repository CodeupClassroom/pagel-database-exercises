
-- List the first 10 distinct last name sorted in descending order.
select distinct last_name
from employees
order by last_name desc
limit 10
;


-- Find all previous or current employees hired in the 90s and born on Christmas. 
-- Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results 
-- to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

select first_name, last_name
from employees
where birth_date like '%12-25'
	and hire_date like '199%'
order by hire_date
limit 5
;

-- Try to think of your results as batches, sets, or pages. 
-- The first five results are your first page. The five after that would be your second page, etc. 
-- Update the query to find the tenth page of results.

select first_name, last_name
from employees
where birth_date like '%12-25'
	and hire_date like '199%'
order by hire_date
limit 5 offset 45
;

-- LIMIT and OFFSET can be used to create multiple pages of data. 
-- What is the relationship between OFFSET (number of results to skip), 
-- LIMIT (number of results per page), and the page number?

-- (number of results per page * number of pages) - result of one page

