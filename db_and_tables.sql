# Databases and Tables

-- Welcome to MySQL!
-- This lesson is to introduce you to the structure of MySQL

-- the double dash represents a single line comment

/* this
is
how
we do a mult-line comment */

-- MySQL is utilizes a database structure
-- our MySQL server has multiple databases

-- we will write queries to navigate our databases
-- all queries should end with a ; 

-- let's see what's inside
-- COMMAND: SHOW DATABASES

show databases;

-- what do we see? 
-- output and action output

-- let's dive into one of the databases
-- we're going to look at the database titled 'albums_db'
-- COMMAND: USE [database_name]

use albums_db;

-- did it work? 
-- let's verify by checking what database we're currently using
-- COMAND: SELECT DATABASE()

select database();

-- let's see how this database was created
-- COMMAND: SHOW CREATE DATABASE [database_name]

show create database albums_db;

-- let's go to another database
-- how do we see our databases again?

show databases;

-- lets switch to the 311_data database and verify

use 311_data;

select database();

-- now that we are in the 311_data database, let's see what's inside
-- we're gonna go back to our show command
-- COMMAND: SHOW TABLES

show tables;

-- what do we see?

-- now let's see how SOURCE table was created
-- COMMAND: SHOW CREATE TABLE [table_name]

show create table source;



