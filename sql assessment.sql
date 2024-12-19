create database sql_assessment;
use sql_assessment;

-- Creating Employee table
CREATE TABLE employee (
    empid SERIAL PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
  
);

-- Inserting data into Employee table
INSERT INTO employee (name, department, salary) VALUES
('Alice Smith', 'HR', 55000.00),
('Bob Johnson', 'HR', 55000.00),
('Charlie Brown', 'HR', 60000.00),
('David Lee', 'HR', 62000.00),
('Emma Watson', 'IT', 65000.00),
('Franklin Adams', 'IT', 70000.00),
('Grace Taylor', 'Finance', 75000.00),
('Henry Ford', 'Admin', 80000.00);

-- Creating Department table
CREATE TABLE department (
    dep_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

-- Inserting data into Department table
INSERT INTO department (department_name, location) VALUES
('HR', 'Headquarters'),
('Admin', 'Central Office'),
('IT', 'Tech Park'),
('Finance', 'Financial District'),
('Sales', 'Sales Complex'),
('Marketing', 'Marketing Hub');

select * from employee;
select * from department;

-- Question Answer:-

-- 1. Select all employees from the HR department:
select * from employee where department="HR";

 -- 2. Count the number of employees in each department:
 select  department,count(*) from employee GROUP BY department;
 
 -- 3. Find employees with a salary greater than the average salary:
 select * from employee where salary> ( select avg(salary) from employee);
 
-- 4. Find departments with more than 2 employees:
select department from employee GROUP BY department having count(*)>2;

-- 5. List employees along with their department information:
select e.empid,e.name,d.dep_id,d.department_name,d.location from employee as e inner join department d on d.department_name=e.department;

-- 6. List all departments and their employees, even if there are no employees assigned:
select e.empid,e.name,d.department_name,d.location,d.dep_id from department d left join employee e on d.department_name=e.department;

-- 7. Find the highest salary among all employees:
select max(salary) as highest_salary from employee;

-- 8. Find the average salary for each department:
select department,avg(salary) as average_salary from employee GROUP BY department;

-- 9. Calculate the total salary for each department:
select department,sum(salary) total_salary from employee GROUP BY department;

-- 10. Rank employees by salary within each department:
select *,DENSE_RANK() over(partition by department order by salary) from employee;

-- 11. Find the employee with the highest salary in each department:
select * from employee where (department,salary) in 
(select department,max(salary) highest_salary from employee GROUP BY department);

-- 12. List employees whose names start with 'A':
select * from employee where name like 'A__%';

-- 13. Find employees with salaries between 60000 and 80000
select * from employee where salary between 60000 and 80000;

-- 14. List departments located in 'Headquarters' or 'Tech Park':
select * from department where location IN("Headquarters","Tech Park");

-- 15. Count the number of employees per character length of their name:
select length(name) name_length,count(*) from employee GROUP BY name_length;

-- 16. Find employees whose name contains 'son':
select * from employee where name like '%son%';

-- 17. Find the employee with the lowest salary:
select empid,name,department,salary from employee where salary=(select min(salary) from employee);

-- 18. Find employees whose departments not 'HR':
select * from employee where department != 'HR';
 
-- 19. List employees with a salary greater than 60000 and sorted by salary in descending order:
select * from employee where salary>60000 ORDER BY  salary desc;

-- 20.List all employees along with their department and location, but only for departments with more than 1 employee:
select * from employee;
select * from department;
select d.department_name,d.location from employee e right join department d on e.department=d.department_name
GROUP BY d.department_name,d.location having count(d.department_name)>1;

-- 21. Find the department with the highest average salary among employees:
select department,avg(salary) average_salary from employee group by department order by avg(salary) desc limit 1; 

-- 22.List all employees who have the same salary as at least one other employee:
select empid,name,department,salary from employee 
where salary=any(select salary from employee GROUP BY salary having count(*)>1);

select * from employee 
where salary in(select salary from employee GROUP BY salary having count(*)>1);

-- 23.Find the employee(s) with the highest salary in each location:
select e.name,e.department,d.location,e.salary
from employee e inner join department d 
on e.department=d.department_name
where (e.department,e.salary) in (select department,max(salary) from employee
GROUP BY department); 

-- 24.List all departments and the average salary of employees within each department, sorted by average salary in descending order:
select empid,name,department,avg(salary) average_salary from employee GROUP BY department,empid,name ORDER BY avg(salary) desc;

-- 25.Find the employee(s) with the highest salary who are not in the 'Admin' department:
select empid,name,department,salary as max_salary from employee 
where department not in ( 'Admin') and (department,salary) IN
(select department,max(salary) from employee group by department);

-- 26.Find the employee(s) with the second-highest salary
select * from employee ORDER BY salary desc limit 1 offset 1;
