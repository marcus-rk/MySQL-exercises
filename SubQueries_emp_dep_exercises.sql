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
    (SELECT IFNULL(AVG(salary), 0) -- NULL set to 0
    FROM employees AS E 
    WHERE E.department_number = D.department_number) AS average_department_salary
FROM departments AS D
ORDER BY average_department_salary DESC;

/* Retrieve the department name and average salary of all departments
 with an average higher than the average department salary
(Advanced 1 - Retrieve all departments and their average salary 
if the department has an salary average higher than the total 
average department salary excluding commission?)

      
I found a solution which uses something called:CTEs (Common Table Expressions) 
CTEs works kindda like variables or helping tables, making the code more readable and remove redundant calculations. */
WITH DepartmentAverages AS (
    SELECT 
	D.department_number,
        IFNULL(AVG(E.salary), 0) AS average_department_salary -- Departments with NULL salary will be set to 0
    FROM departments AS D
    LEFT JOIN employees AS E -- Using LEFT JOIN to keep departments with 0 employeers or NULL
		ON D.department_number = E.department_number
    GROUP BY D.department_number
),
OverallAverage AS (
    SELECT AVG(average_department_salary) AS overall_average_salary
    FROM DepartmentAverages
)

SELECT D.department_name, DA.average_department_salary, OA.overall_average_salary
FROM departments AS D
INNER JOIN DepartmentAverages AS DA 
	ON D.department_number = DA.department_number
CROSS JOIN OverallAverage AS OA -- CROSS JOIN adds the overall average salary to every row
WHERE DA.average_department_salary > OA.overall_average_salary;


/* This is the first solution I tried using only sub-queries
The problem with this code is it doesn't account for departments
with 0 employees or salary at NULL


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
       
*/

/* Advanced 2 - Retrieve all departments and their average salary 
if the department has an salary average higher than the total 
average department salary INCLUDING commission? */
WITH DepartmentAverages AS (
    SELECT 
		D.department_number,
        IFNULL(AVG(E.salary + E.commission), 0) AS average_department_salary -- Added commission to salary
    FROM departments AS D
    LEFT JOIN employees AS E
		ON D.department_number = E.department_number
    GROUP BY D.department_number
),
OverallAverage AS (
    SELECT AVG(average_department_salary) AS overall_average_salary
    FROM DepartmentAverages
)

SELECT D.department_name, DA.average_department_salary, OA.overall_average_salary
FROM departments AS D
INNER JOIN DepartmentAverages AS DA 
	ON D.department_number = DA.department_number
CROSS JOIN OverallAverage AS OA
WHERE DA.average_department_salary > OA.overall_average_salary;

