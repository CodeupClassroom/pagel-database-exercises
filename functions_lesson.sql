# FUNCTIONS

-- SQL has built in functions. Yay! 




-- takes in data, performs a task on the data, exports transformed data
-- typically used in the select statement, as they are manipulating our output data
-- FORMAT: name_of_function([input])

-- note: they require parenthesis!! 
-- also: they don't always require an input 


-- Let's investigate
   -- numeric functions
   -- string functions
   -- datetime functions
   -- casting


-- an example of what we've seen so far
select database();


-- Let's use the albums db for demo

show databases;
use albums_db;
select database();
show tables;



# NUMERICAL FUNCTIONS

-- count: returns the number of rows in query
-- FORMAT: count(*)

select * from albums;

use employees;

select count(*) as cnt
from employees;

select count(*) 
from employees
;

use albums_db;


-- min, max, avg
-- FORMAT: MIN([input]), MAX([input], AVG([input])


select MIN(sales) as min_sales
	, MAX(sales) as max_sales
    , AVG(sales) as average_sales
    , COUNT(*) as cnt_of_albums
from albums;

-- FORMAT: ROUND([input], 2)
select ROUND(sales,0)
from albums;

-- how to combine functions
-- contain each function inside the parenthesis
-- AVG(sales) is the input for the ROUND function in this example
select MIN(sales) as min_sales
	, MAX(sales) as max_sales
    , ROUND(AVG(sales), 2) as average_sales
    , COUNT(*) as cnt_of_albums
from albums;


-- STRING FUNCTIONS

-- concat: combines things together
-- FORMAT: CONCAT([value1], [value2],[value3],.....)

select concat('hello', 'pagel', '!');

select 'hellopagel!';


-- combining two columns together
select * from albums;

select 
	concat(release_date, ' -- ' ,name) as release_date_album
    , sales
    , release_date -- still pull back in a column that was combined
    , artist
from albums
;


-- substr: extracts a portion of element 
-- FORMAT: SUBSTR(string, start_position, how_many_elements_to_retrieve)

select 'hello pagel class!';

select SUBSTR('hello pagel class!', 7, 5);

select SUBSTR('hello pagel class!', 7, 30); -- putting a bigger number doesnt break

select SUBSTR('hello pagel class!', 7, -5); -- cant count backwards

select SUBSTR('hello pagel class!', -5, 3); -- can start counting from the end of the string

select SUBSTR('hello pagel class!', 7); -- the last argument is optional,
-- and defaults to returning whatever is left

select SUBSTR('hello pagel class!', -5, 3);

select database();

select release_date, SUBSTR(release_date, 3) as two_digit_year
from albums;


select * -- locate('', name)
from albums;

-- finds the position of the first space and returns that as the length of the element
select name, substr(name, 1, locate(' ', name))
from albums;

-- case conversation: uppercases or lowercases 
-- FORMAT: UPPER([input],), LOWER([input])

select 
	UPPER(artist) as all_caps_artist   , lower(name) as all_lower_album -- whitespace doesnt matter
    , UPPER( concat(artist, ' -- ', name) ) as date_album -- combining two functions
    , concat( LOWER(artist), ' /  ', UPPER(name)) -- combining in another way
    , sales
from albums;

SELECT name, 
        UPPER(  LEFT(name,1))
        ,LOWER( SUBSTR(name,2) )
        ,CONCAT( 
			UPPER(  LEFT(name,1)) -- uppercase the first letter
			, 
			LOWER( SUBSTR(name,2) ) -- lowercasing everything starting at the second letter
        )
FROM albums;



-- replace: replaces a piece of a string with another string
-- FORMAT: REPLACE(string, what_we_want_to_remove, new_string )

select REPLACE('hello pagel class!', 'pagel', '~~~PAGEL!!!!');

select REPLACE('hello pagel class!', 'a', 'AAAAA');

select name, genre, REPLACE(genre, 'rock', '!@#ROCK!!!') -- it is case sensitive
from albums;

select name
	, genre
	, REPLACE(lower(genre), 'rock', '!@#ROCK!!!') -- lowercase the genre to find all of them! 
from albums;


-- TIME AND DATE FUNCTIONS
-- descriptive functions

select NOW(); -- date and time of right now

select current_date(); -- date of today
select curdate(); -- date of today
select curtime(); -- time of right now (in a different timezone)

select now(), current_date(), curdate(), curtime();

-- FORMAT:  CONVERT_TZ([time],[db_time],[change_in_current_time])
select CONVERT_TZ(now(),'+00:00','-6:00');

-- we can pull out elements of date 
-- YEAR([input_date]), MONTH([input_date]), DAY([input_date])

select now(), year(now()), month(now()), DAY(now()), HOUR(now());

select year('1999/01/12'), year('1999-01-12');


-- CASTING: changing the data 
-- FORMAT: CAST([value] as [datatype])

select 2 + 2;

select 1 + '2';

select concat('1' ,'2'); -- to actually get the output to be 12 

select 1 + CAST('2' as SIGNED); -- not necessary


