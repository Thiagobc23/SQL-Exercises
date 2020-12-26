-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
    
select s.Name, p.Name, p.Hours
from assignedto a, scientists s, projects p 
where a.Project = p.Code 
and a.Scientist = s.SSN
order by p.Name ASC, s.Name ASC;


-- 6.2 Select the project names which are not assigned yet
select * 
from (select * from projects p left outer join assignedto a on p.Code = a.Project) x
where Scientist is null;

select * from projects p where p.Code not in (select distinct Project from assignedto)