-- Makj0005 
-- link til opgaver: https://nicklasdean.gitbook.io/ita2023-1.-semester/data-literacy/04-joins

USE emp_dep; -- use correct database

/* Join the two tables by department_number and display all */
SELECT *
FROM departments
INNER JOIN employees 
	ON departments.department_number = employees.department_number;

/* Retrieve all the employees from Accounting (using joins) */
SELECT *
FROM departments
INNER JOIN employees
	ON departments.department_number = employees.department_number
    WHERE department_name = "ACCOUNTING";
    
/* Retrieve only the names of all employees from OPERATIONS and RESEARCH (No one in operations) */
SELECT employee_name
FROM departments
INNER JOIN employees
	ON departments.department_number = employees.department_number
    WHERE department_name = "OPERATIONS" OR department_name = "RESEARCH";
    
/* Retrieve all names of all salesman from Chicago */
SELECT employee_name, department_name, location
FROM departments
INNER JOIN employees
	ON departments.department_number = employees.department_number
    WHERE department_name = "SALES" 
    AND location = "CHICAGO";
    
/* Retrieve the names of all salesmen that are not from Chicago */
SELECT employee_name, department_name, location
FROM departments
INNER JOIN employees
	ON departments.department_number = employees.department_number
    WHERE department_name = "SALES" 
    AND location != "CHICAGO";
    
/* Retrieve the id of all clerks from New York */
SELECT id, job, location
FROM departments
INNER JOIN employees
	ON departments.department_number = employees.department_number
    WHERE location = "NEW YORK"
    AND job = "CLERK";

/* Retrieve all data from employees and their department except clerks or employees from New York with a comission */ 
SELECT
	E.id,
	E.employee_name,
	E.job,
	E.manager,
	E.hiredate,
	E.salary,
	E.commission,
	D.department_name,
	D.location
FROM departments AS D
INNER JOIN employees AS E
	ON D.department_number = E.department_number
    WHERE job != "CLERK"
    OR (location = "NEW YORK" AND (commission = 0 OR commission IS NULL));
