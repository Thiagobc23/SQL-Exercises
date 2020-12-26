-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers
-- 5.1 Select the name of all the pieces. 
select Name from pieces;

-- 5.2  Select all the providers' data. 
select * from providers;

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
select Piece, avg(Price) from provides group by Piece;

-- 5.4  Obtain the names of all providers who supply piece 1.
select providers.Name 
from providers 
where providers.Code in (select Provider 
						 from provides 
                         where Piece = 1);

-- 5.5 Select the name of pieces provided by provider with code "HAL".
select Name 
from pieces 
where pieces.Code in (select Piece 
					  from provides 
                      where provides.provider = 'HAL');

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
select pieces.Name, providers.Name, p.Price 
from provides p, providers, pieces,
(select max(Price) Price, Piece from provides group by Piece) top_p 
where top_p.Price = p.Price 
and top_p.Piece = p.Piece
and p.Piece = pieces.Code
and p.provider = providers.Code
;

-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
insert into provides values (1, 'TNBC', 7);

-- 5.8 Increase all prices by one cent.
update provides set Price = Price + 1 where provides.Piece > 0;

-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
select * from provides;
delete from provides where Provider = 'RTB' and Piece = 4;

-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
select * from provides;
delete from provides where Provider = 'RBT';