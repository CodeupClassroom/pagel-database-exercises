-- List all the databases
show databases;

-- Write the SQL code necessary to use the albums_db database
use albums_db;

-- Show the currently selected database
select database();

-- List all tables in the database
show tables;


-- Write the SQL code to switch the employees database
use employees;

-- Show the currently selected database
select database();


-- List all the tables in the database
show tables;


-- Explore the employees table. What different data types are present on this table?
show create table employees;

/*
CREATE TABLE `employees` (
  `emp_no` int NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/

show create table employees;

-- Which table(s) do you think contain a numeric type column? 
-- (Write this question and your answer in a comment)
-- dept_emp, dept_manager, salaries, titles

-- Which table(s) do you think contain a string type column? 
-- (Write this question and your answer in a comment)
-- departments, dept_emp, dept_manager, titles


-- Which table(s) do you think contain a date type column? 
-- (Write this question and your answer in a comment)
-- dept_emp, dept_manager, salaries,titles


-- What is the relationship between the employees and the departments tables? 
-- (Write this question and your answer in a comment)

show create table dept_emp;

/*
CREATE TABLE `employees` (
  `emp_no` int NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1

CREATE TABLE `departments` (
  `dept_no` char(4) NOT NULL,
  `dept_name` varchar(40) NOT NULL,
  PRIMARY KEY (`dept_no`),
  UNIQUE KEY `dept_name` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1

CREATE TABLE `dept_emp` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_emp_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_emp_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/





-- Show the SQL that created the dept_manager table. 
-- Write the SQL it takes to show this as your exercise solution.

show create table dept_manager;



-- ADDED THIS EXTRA LINE TO MY FILE