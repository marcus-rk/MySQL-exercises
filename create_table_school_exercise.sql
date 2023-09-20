-- Makj0005
-- link til opgaver: https://nicklasdean.gitbook.io/ita2023-1.-semester/database-design/01-ddl-constraints
CREATE DATABASE IF NOT EXISTS school;

USE school; -- Use correct database

/*
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE IF NOT EXISTS departments (	
	department_number INTEGER, 
	department_name VARCHAR(30), 
	location VARCHAR(30), 
	PRIMARY KEY (department_number)
);

INSERT INTO departments (department_number,department_name,location) VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO departments (department_number,department_name,location) VALUES (20,'RESEARCH','DALLAS');
*/

/* Create a table named "students" with the following columns:
- student_id (primary key, INT)
- first_name (VARCHAR(50))
- last_name (VARCHAR(50))
- birtdate (DATE) --> Nicklas siger det skal være VARCHAR(50)
- enrollment_date (DATETIME)
- status (varchar(15))
*/ 
CREATE TABLE IF NOT EXISTS students (	
	student_id INT AUTO_INCREMENT, -- Added auto_increment
	first_name VARCHAR(50), 
	last_name VARCHAR(50),
    	birthdate VARCHAR(50), -- Ændret til varchar(50) da Nicklas sagde det ift. senere opgave.
    	enrollment_date DATETIME, -- 'YYYY-MM-DD hh:mm:ss'
    	`status` VARCHAR(15),
	PRIMARY KEY (student_id)
);

/* Modify the "students" table by adding a new column named 'email' of type VARCHAR(100). */
ALTER TABLE students
ADD COLUMN email VARCHAR(100);

/* Modify a Column Change such that the data type of the birthdate column in the "students" table to DATE. */
ALTER TABLE students
MODIFY birthdate DATE;

/* Create a new table named "courses" with the following columns:
- course_id (primary key, INT)
- course_name (VARCHAR(100))
- instructor_id (INT, foreign key referencing an "instructors" table)
				(An instructor has a name, email & auto incrementing id)
*/ 

	-- First we make an instructors table
CREATE TABLE IF NOT EXISTS instructors (
	instructor_id INT AUTO_INCREMENT,
	instructor_name VARCHAR(100) NOT NULL,
	instructor_email VARCHAR(100) NOT NULL UNIQUE, -- Made sure that instructors has an unique email
	PRIMARY KEY(instructor_id)
);

	-- Now we make a courses table with foreign key instructor_id
CREATE TABLE IF NOT EXISTS courses (
	course_id INT AUTO_INCREMENT, -- Added auto_increment
	course_name VARCHAR(100),
	instructor_id INT,
	PRIMARY KEY(course_id),
	FOREIGN KEY(instructor_id) REFERENCES instructors(instructor_id)
);

/* Add a default value of 'Active' for the status column in the "students" table. */
ALTER TABLE students
ALTER COLUMN `status` SET DEFAULT 'Active';

/* Create a table named "books" with the following columns:
- book_id (INT, primary key, auto incrementing)
- title (VARCHAR, 100)
- author (VARCHAR, 100)
- isbn (VARCHAR, 13, unique)
*/ 
CREATE TABLE IF NOT EXISTS books (
	book_id INT AUTO_INCREMENT,
	title VARCHAR(100),
	author VARCHAR(100),
	isbn VARCHAR(13) UNIQUE,
	PRIMARY KEY (book_id)
);

/* Populate the tables with at least 1 entity for each table */
	-- insert 1 entity into books
INSERT INTO books(title, author,isbn)
	VALUES ('Best Title','Best Author','1234567891011');
    
SELECT * FROM books;

	-- insert 1 entity into instructors
INSERT INTO instructors(instructor_name, instructor_email)
	VALUES ('Best Instructor','best@instructor.com');
    
SELECT * FROM instructors;

	-- insert 1 entity into courses
INSERT INTO courses(course_name, instructor_id)
	VALUES ('Best Course Name',1);
    
SELECT * FROM courses;

	-- insert 1 entity into students
INSERT INTO students(first_name,last_name,birthdate,enrollment_date,email)
	VALUES ("Bob","Hansen",'1999-10-20','2023-10-20 11:20:35','bob@Hansen.com');
    
SELECT * FROM students;


/* Modify the database such that 1 book is used on each course */
	-- My idea: You could add book_id as foreign key in course
    
	-- adding column for book_id in courses table
ALTER TABLE courses 
ADD COLUMN book_id INT; -- NOT NULL is optional

	-- Assign FOREIGN KEY to book_id column in courses table
ALTER TABLE courses 
ADD FOREIGN KEY (book_id) REFERENCES books(book_id);

	-- Test book_id foreign key in courses
INSERT INTO courses(course_name, instructor_id, book_id)
	VALUES ('Worst Course Name',1,1);

SELECT * FROM courses;
