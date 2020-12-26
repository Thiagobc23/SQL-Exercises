-- https://en.wikibooks.org/wiki/SQL_Exercises/Planet_Express 
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".
    
select * from client where AccountNumber = (select Recipient from package where Weight = 1.5);

select Client.Name
from package, client 
where package.Recipient = client.AccountNumber 
and package.Weight = 1.5;

-- 7.2 What is the total weight of all the packages that he sent?
select sum(Weight) from package where Sender = 2;