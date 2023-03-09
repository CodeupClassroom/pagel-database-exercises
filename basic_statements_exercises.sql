-- Use the albums_db database.

use albums_db;
select database();

-- What is the primary key for the albums table?

show tables;

select id 
from albums;

-- What does the column named 'name' represent?

select *
from albums;
-- name of the album 


-- What do you think the sales column represents?
-- dollars or copies?
-- millions? billions? thousands?
-- probably millions of copies


-- Find the name of all albums by Pink Floyd.

select artist, name
from albums
where artist = 'Pink Floyd'
;

-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
select release_date
from albums
where name = 'Sgt. Pepper\'s Lonely Hearts Club Band' -- with escape character backslash
;

select release_date, name
from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band" -- with double quotes 
;

select release_date, name
from albums
where name = 'Sgt. Pepper''s Lonely Hearts Club Band' -- can escape with another single quote
;


-- What is the genre for the album Nevermind?

select genre
from albums
where name = 'Nevermind'
;


-- Which albums were released in the 1990s?
select name, release_date
from albums
where release_date between 1990 and 1999 
;

-- Which albums had less than 20 million certified sales?
select name, sales
from albums
where sales < 20
;

