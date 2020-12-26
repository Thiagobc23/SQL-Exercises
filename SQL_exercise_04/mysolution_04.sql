-- https://en.wikibooks.org/wiki/SQL_Exercises/Movie_theatres
-- 4.1 Select the title of all movies.
select Title from movies;

-- 4.2 Show all the distinct ratings in the database.
select distinct Rating from movies;

-- 4.3  Show all unrated movies.
select * from movies where Rating is null;

-- 4.4 Select all movie theaters that are not currently showing a movie.
select * from movietheaters where movie is null;

-- 4.5 Select all data from all movie theaters 
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
select mt.*, mv.* from movies mv right outer join movietheaters mt on mv.Code = mt.Movie;

-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
select * from movies left join movietheaters on movies.Code = movietheaters.Movie;

-- 4.7 Show the titles of movies not currently being shown in any theaters.
select * 
from movies mv 
where mv.Code not in (select distinct Movie 
					  from movietheaters mt 
                      where mt.Movie is not null);

-- 4.8 Add the unrated movie "One, Two, Three".
select * from movies;
insert into movies values (9, 'One, Two, Three', null);

-- 4.9 Set the rating of all unrated movies to "G".
update movies
set movies.Rating = 'G'
where movies.Rating is null
and Code > 0;

-- 4.10 Remove movie theaters projecting movies rated "NC-17".
delete from movietheaters where Movie in (select Code from movies where Rating = 'NC-17')