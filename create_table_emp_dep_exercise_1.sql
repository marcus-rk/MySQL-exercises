-- Makj0005
-- link til opgaver: https://nicklasdean.gitbook.io/ita2023-1.-semester/database-design/01-ddl-constraints
CREATE DATABASE IF NOT EXISTS emp_dep_2;

USE emp_dep_2;

-- Exercise 1 --
CREATE TABLE IF NOT EXISTS departments (	
	department_number INTEGER CHECK(department_number BETWEEN 0 AND 1000), -- changed
	department_name VARCHAR(30) NOT NULL, -- changed
	location VARCHAR(30) NOT NULL, -- changed
	PRIMARY KEY (department_number)
);

CREATE TABLE IF NOT EXISTS employees(	
	id INTEGER, 
	employee_name VARCHAR(30), 
	job VARCHAR(30), 
	manager INTEGER DEFAULT(7839), 
	hiredate DATE CHECK(YEAR(hiredate) > 1980), -- changed
	salary INTEGER CHECK(salary >= 0), -- changed
	commission INTEGER, 
	department_number INTEGER, 
	PRIMARY KEY (id),
	FOREIGN KEY (department_number) REFERENCES departments(department_number)
);

/* Insert two rows for each of the constraints / rules. One valid and one invalid.
Verify that your constraints work as intended.*/
-- departments correct and not correct
INSERT INTO departments(department_number, department_name, location)
	VALUES (10,'SALES','NEW YORK'); -- Valid
INSERT INTO departments(department_number, department_name, location)
	VALUES (1001,NULL,NULL); -- Not valid

-- employees correct and not correct
INSERT INTO employees(id, employee_name, job,manager,hiredate,salary,commission,department_number)
	VALUES (1,'BOB','MANAGER',7839,'2023-10-20',0,0,10);
INSERT INTO employees(id, employee_name, job,manager,hiredate,salary,commission,department_number)
	VALUES (1,'BOB','MANAGER',7839,'2023-10-20',0,0,10);
