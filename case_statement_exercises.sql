use employees;

-- Write a query that returns all employees, their department number, 
-- their start date, their end date, and a new column 'is_current_employee' 
-- that is a 1 if the employee is still with the company and 0 if not.

select
	emp_no
    , concat(first_name, ' ', last_name) as full_name 
    , dept_no
    , hire_date
    , to_date
 --   , if(to_date > now(), 1, 0) as is_current_employee -- one option
 --   , if(to_date > now(), TRUE, FALSE) as is_current_employee -- another option
    , to_date > now() as is_current_employee -- shortest option
from employees
	join dept_emp
		using (emp_no)
;


-- Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
-- depending on the first letter of their last name.

select first_name
from employees
where left(first_name,1) <= 'H' 
;

select first_name, left(first_name,1), substr(first_name, 1,1)
from employees;


select first_name, last_name,
	case 
		when left(last_name,1) <= 'H' then 'A-H'
        when left(last_name,1) <= 'Q' then 'I-Q'
        else 'R-Z'
	end as alpha_group
from employees
;

-- How many employees (current or previous) were born in each decade?

select min(birth_date), max(birth_date) from employees
;

select count(*),
	case
		when birth_date like '195%' then '50s'
        else '60s'
	end as birth_decade -- , count(*)
from employees
group by birth_decade
;


-- What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

select * from salaries limit 10;
select * from dept_emp limit 10;

select
    round(avg(salary),2) -- order doesnt matter in the select statement
	,
    case 
		when dept_name IN ('research','development') then 'R&D'
        when dept_name IN ('sales','marketing') then 'Sales & Marketing'
        when dept_name IN ('Production', 'Quality Management') then 'Prod & QM'
        when dept_name IN ('Finance', 'human resources') then 'Finance & HR'
        else dept_name
	end as dept_group
    -- , round(avg(salary),2)
from departments
	join dept_emp
		using (dept_no)
	join salaries
		using (emp_no)
where salaries.to_date > now()
	and dept_emp.to_date > now()
group by dept_group 
;



-- Write a query that returns all employees, their department number, 
-- their start date, their end date, and a new column 'is_current_employee' 
-- that is a 1 if the employee is still with the company and 0 if not.
-- WITH REMOVING DUPLICATE EMPLOYEES

select *
from employees;

select emp_no, max(to_date)
from dept_emp
group by emp_no
;

select employees.emp_no
	, concat(first_name, ' ', last_name)
    , hire_date
    , max_date
    , dept_no
	, if(max_date > now(), TRUE, FALSE) as is_current_employee
from employees
	join 
		(
        select emp_no, max(to_date) as max_date
		from dept_emp
		group by emp_no
        ) as current_hire_date
        using (emp_no)
	join dept_emp
		on dept_emp.to_date = current_hire_date.max_date
        and dept_emp.emp_no = current_hire_date.emp_no
;

-- wilsons short method
SELECT emp_no
	, dept_no
--    , from_date
	, employees.hire_date
    , to_date
    , to_date > NOW() AS 'is_current_employee'
    FROM dept_emp
		join employees
			using (emp_no)
	WHERE (emp_no, to_date) IN (SELECT emp_no, MAX(to_date) FROM dept_emp GROUP BY emp_no)

    
    ;








