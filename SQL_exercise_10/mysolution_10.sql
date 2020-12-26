-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
select 
	a.id, 
	a.address, 
    a.updatedate 
from 
	address a, 
	(select id, max(updatedate) up_date from address group by id) ma 
where 
	a.id = ma.id 
	and a.updatedate = ma.up_date;

select a.id, a.address, max(a.updatedate) from address a group by a.id, a.address

    -- i.e., the joined table should have the same number of rows as table PEOPLE
-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person. 
    -- i.e., the joined table should have the same number of rows as table PEOPLE
