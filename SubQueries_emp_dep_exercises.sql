-- Makj0005 
-- link til opgaver: https://nicklasdean.gitbook.io/ita2023-1.-semester/data-literacy/06-analysis-subqueries

USE emp_dep;  -- use correct database

/* Retrieve the average salary of all employees */
SELECT AVG(salary)
FROM employees;

/* Retrieve the names of employees with a salary above the average */
SELECT employee_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
    
/* Retrieve the department name and average salary of all departments */
SELECT
    D.department_name,
    (SELECT AVG(salary) 
    FROM employees AS E 
    WHERE E.department_number = D.department_number) AS average_department_salary
FROM departments AS D;

/* Retrieve the department name and average salary of all departments
 with an average higher than the average department salary */
SELECT department_name, 
	-- Calculate the average salary for each department
	(SELECT AVG(salary) 
    FROM employees AS E 
    WHERE E.department_number = D.department_number) AS average_department_salary
FROM departments AS D
    -- Check if the department's average salary is higher than the overall average department salary
    -- (There might be a better solution, that do not calculate the average_department_salary two times)
HAVING average_department_salary > 
           (SELECT AVG(average_department_salary) AS overall_average_salary
           FROM (
               -- Calculate the average salary for each department (again)
               SELECT AVG(salary) AS average_department_salary
               FROM employees
               GROUP BY department_number
           ) AS department_averages
       );
