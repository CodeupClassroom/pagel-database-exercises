# IF and CASE STATEMENTS

-- what is it: controlling the flow of the program with conditional statements

-- lets use the chipotle database
use chipotle;
show tables;

select * from orders;

-- lets look at all the chicken orders

select distinct item_name
from orders
where item_name LIKE '%chicken%'
;


### IF FUNCTION

-- check this condition, 
	-- if this condition is true, do this, 
	-- if not, do that

/*
FORMAT: IF(condition, value_if_true, value_if_false)
*/

-- if statements are generally best for T/F 
-- these hang out in the SELECT statement (manipulating our output data)

-- use if statement to find out if an item is a chicken bowl
select distinct item_name, if(item_name = 'Chicken Bowl', 'yes', 'no') as is_chicken_bowl
from orders
;

-- output values also work with not-strings
select distinct item_name, if(item_name = 'Chicken Bowl', 1, 0) as is_chicken_bowl
from orders
;

select distinct item_name, if(item_name = 'Chicken Bowl', 'TRUE', 'FALSE') as is_chicken_bowl
from orders
;

-- its recongizing the TRUE and FALSE, but it stores them as a 1 and 0 
select distinct item_name, if(item_name = 'Chicken Bowl', TRUE, FALSE) as is_chicken_bowl
from orders
;

-- can be used with any conditional statement
select distinct item_name, if(item_name = 'Chicken Bowl', TRUE, FALSE) as is_chicken_bowl
from orders
;

-- this is making another column that can be added on to any part of the table
select *, if(item_name = 'Chicken Bowl', TRUE, FALSE) as is_chicken_bowl
from orders
;

										 
-- shortcut! 
select distinct item_name
	, if(item_name like '%Chicken%', TRUE, FALSE) as has_chicken -- long way
from orders
;

-- dont have to explictly type out the IF() when the output is TRUE OR FALSE 
select distinct item_name
	,item_name like '%Chicken%' as has_chicken -- short way
from orders
; -- output will always be 1 and 0 for TRUE and FALSE


-- extra: count the unique chicken items

-- using a groupby will count every instance of them 
select
	if(item_name like '%Chicken%','yes','no' ) as has_chicken
	, count(*)
from orders
group by has_chicken;

select sum(has_chicken) -- able to isolate the new column 'has_chicken'
from 
	(
	select item_name
		, if(item_name like '%Chicken%',TRUE, FALSE ) as has_chicken
	from orders
	) as chicken -- the subquery is returning a table
;

-- using a subquery will give us back the unique instances of chicken with our distinct
select sum(has_chicken) -- able to isolate the new column 'has_chicken'
from 
	(
	select distinct item_name
		, if(item_name like '%Chicken%',TRUE, FALSE ) as has_chicken
	from orders
	) as chicken -- the subquery is returning a table
;

-- confirmed that theres only 6 unique chicken items
select distinct item_name
	, if(item_name like '%Chicken%',TRUE,FALSE ) as has_chicken
from orders
;


# CASE STATEMENT - option 1

-- single out a single column
-- check if it EQUALS something, if it does, perform an action and exit
-- check if it EQUALS a second thing, if it does, perform that action instead and exit
-- if it doesnt equal any of the above values, perform an action for whatever is left and exit

/* 
FORMAT:
CASE [column_name]
	WHEN [condition_a] THEN [output_value_a]
	WHEN [condition_b] THEN [output_value_b]
	ELSE [output_value_c]
END as [new_column_name] 
*/

-- we are only checking ONE column
-- we are only checking for EQUALITY
-- but we can check for more than TRUE and FALSE

select distinct item_name from orders;
-- lets find the bowls
select distinct item_name,
	CASE item_name -- this is the column im checking
		when 'Chicken Bowl' then 'yes_chicken_bowl'
        when 'Steak Bowl' then 'yes_steak_bowl'
        when 'Izze' then 'yes_izze'
        when '%Burrito%' then 'yes_some_burritos' -- this wont find them because we need a like
        -- this format only checks for EQUALITY 
        else 'other'
	END as some_items
from orders
; -- the equals sign is implied in this format and can not be changed



# CASE STATEMENT - option 2

-- check for a condition, if true, perform an action and exit
-- check for another condition, if true, perform an action and exit
-- and for whatever is left, perform an action and exit

/* 
FORMAT: 
CASE 
	WHEN [column_a condition_a] THEN [output_value_a]
	WHEN [column_b condition_b] THEN [output_value_b]
	ELSE value_c
END AS [new_column_name]

*/

-- more flexibility
-- can check different columns
-- can use different operators than EQUALS
-- ORDER MATTERS
-- in general, this is the preferred format

select distinct item_name from orders;

-- lets find bowls again

select distinct item_name,
	CASE 
		WHEN item_name = 'Chicken Bowl' then 'is_chicken_bowl' -- check first, 
        -- and if the condition is TRUE, it doesnt check other conditions, it exits the case statement
		WHEN item_name LIKE '%bowl%' then 'other_bowl'
        -- if we don't put an else statement, any given not met will be NULL
        end 'find_bowls'
from orders;

select *,
	CASE 
		WHEN item_name = 'Chicken Bowl' then 'is_chicken_bowl'
		WHEN item_name = 'Steak Bowl' then 'is_steak_bowl'
        WHEN item_name LIKE '%bowl%' then 'other_bowl'
        WHEN order_id < 4 then 'early_order' -- can check different columns
        end 'find_bowls',
	CASE 
		when choice_description LIKE '%tomato%' then 'contains_tomato'
	END
from orders
;

-- showing why item price is weird aka a string not a number
select distinct item_price
from orders
order by item_price
;


-- lets group our quantities
select quantity
from orders
group by quantity
;


-- create categories for how many times a person ordered a specific item in an order
select distinct quantity,
	CASE 
		when quantity >= 5 then 'big_orders'
        when quantity >= 2 then 'middle_orders'
        else 'single_orders'
	END as 'order_size'
from orders
;

-- find out how many times people ordered the different sizes
select count(*), order_size -- can now use my count by category because of the groupby
from 
	(select id, quantity,
		CASE 
			when quantity >= 5 then 'big_orders'
			when quantity >= 2 then 'middle_orders'
			else 'single_orders'
		END as 'order_size'
	from orders) as orders
group by order_size -- this is the category im trying to isolate
;




### pivot table

select * from orders;

-- lets find all the chicken orders

select distinct item_name 
from orders 
where item_name like '%chicken%';


-- look at chicken orders and quantity

select quantity, item_name 
from orders 
where item_name like '%chicken%';


-- building all the columns 

select quantity, item_name,
	case when item_name = 'Chicken Bowl' then item_name end as 'Chicken Bowl', -- each separate case statements which make their own columns
	case when item_name = 'Chicken Crispy Tacos' then item_name end as 'Chicken Crispy Tacos',
	case when item_name = 'Chicken Soft Tacos' then item_name end as 'Chicken Soft Tacos',
	case when item_name = 'Chicken Burrito' then item_name end as 'Chicken Burrito',
	case when item_name = 'Chicken Salad Bowl' then item_name end as 'Chicken Salad Bowl',
	case when item_name = 'Chicken Salad' then item_name end as 'Chicken Salad'
from orders 
where item_name like '%chicken%';


-- adding groupby and count

select quantity,
	count(case when item_name = 'Chicken Bowl' then item_name end) as 'Chicken Bowl',
	count(case when item_name = 'Chicken Crispy Tacos' then item_name end) as 'Chicken Crispy Tacos',
	count(case when item_name = 'Chicken Soft Tacos' then item_name end) as 'Chicken Soft Tacos',
	count(case when item_name = 'Chicken Burrito' then item_name end) as 'Chicken Burrito',
	count(case when item_name = 'Chicken Salad Bowl' then item_name end) as 'Chicken Salad Bowl',
	count(case when item_name = 'Chicken Salad' then item_name end) as 'Chicken Salad'
from orders 
where item_name like '%chicken%'
group by quantity
order by quantity
;



