-- LINK : https://en.wikibooks.org/wiki/SQL_Exercises/Employee_management
-- 2.1 Select the last name of all employees.
select LastName from employees;

-- 2.2 Select the last name of all employees, without duplicates.
select distinct LastName from employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
select * from employees where LastName = 'Smith';

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
select * from employees where LastName = 'Smith' or LastName = 'Doe';

-- 2.5 Select all the data of employees that work in department 14.
select * from employees where department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
select * from employees where department = 37 or department = 77;

-- 2.7 Select all the data of employees whose last name begins with an "S".
select * from employees where LastName like 'S%';

-- 2.8 Select the sum of all the departments' budgets.
select sum(budget) from departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
select department, count(SSN) employee_number from employees group by department;

-- 2.10 Select all the data of employees, including each employee's department's data.
select * from employees inner join departments on (employees.Department = departments.Code);

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
select employees.Name, 
	employees.LastName, 
	departments.Name, 
    departments.Budget 
from employees, departments 
where employees.Department = departments.Code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
select 
	employees.Name, 
    employees.LastName 
from 
	employees
where 
	employees.Department in (select departments.Code from departments where departments.Budget > 60000);

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
select departments.Name 
from departments 
where departments.Budget > (select avg(departments.Budget) from departments);

-- 2.14 Select the names of departments with more than two employees.
select employees.Department from employees group by Department having count(employees.SSN) > 2;

-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
select Name, LastName 
from employees 
where 
	Department = (
		select x.Code from
		(select Code, Budget from departments order by Budget ASC limit 2) x
		order by Budget DESC limit 1);

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
select * from departments;
insert into departments values (11, 'Quality Assurance', 40000);

-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
select * from employees;
insert into employees values (847219811, 'Mary', 'Moore', 11);

-- 2.17 Reduce the budget of all departments by 10%.
update departments set budget = budget * 0.9 where departments.Code > 0;

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
update employees
set employees.Department = 14
where employees.SSN > 0 
and employees.Department = 77;

-- 2.19 Delete from the table all employees in the IT department (code 14).
delete from employees where employees.Department = 14;

-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
delete from employees 
where 
	employees.Department in (select departments.Code 
							 from departments 
                             where departments.Budget > 60000);

-- 2.21 Delete from the table all employees.
delete from employees where employees.SSN > 0;

select * from employees