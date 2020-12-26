-- 9.1 give the total number of recordings in this table
select count(*) from cran_logs;

-- 9.2 the number of packages listed in this table?
select count(distinct package) from cran_logs;

-- 9.3 How many times the package "Rcpp" was downloaded?
select count(*) from cran_logs where package = 'Rcpp';

-- 9.4 How many recordings are from China ("CN")?
select count(*) from cran_logs where country = 'CN';

-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
select package, count(1) downloads from cran_logs group by package order by downloads desc;

-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
select 
	package, 
	count(1) downloads, 
    RANK() OVER (
        ORDER BY count(1) desc
    ) my_rank
from cran_logs 
where time between '09:00:00' and '11:00:00'
group by package 
order by downloads desc;

-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
select * 
from cran_logs 
where country in (select 'CN' val union all 
				  select 'JP' val union all 
                  select 'SG' val);

-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")
select count(*) downloads, country 
from cran_logs 
group by country 
having downloads > (select count(*) from cran_logs where country = 'CN');

-- 9.9 Print the average length of the package name of all the UNIQUE packages
select avg(len) from (
select distinct length(package) len from cran_logs) x;

-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
select * from (
select count(*) downloads, package from cran_logs group by package order by downloads desc limit 2) x
order by downloads asc limit 1;

-- 9.11 Print the name of the package whose download count is bigger than 1000.
select count(*) downloads, package from cran_logs group by package having downloads > 1000;

-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).
select count(*) downloads, count(*) / (select count(*) from cran_logs) percent, r_os from cran_logs group by r_os order by downloads desc;

