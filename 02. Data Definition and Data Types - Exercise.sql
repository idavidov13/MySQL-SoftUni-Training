--01. Create Tables - In the newly created database Minions add table minions (id, name, age). Then add new table towns (town_id,
--name). Set id and town_id columns of both tables to be primary key as constraint, id's must be auto increment.
--Submit yours create table queries in Judge together for both tables (one after another separated by ";") as Run
--queries & check DB.

CREATE TABLE minions (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(47),
    age INT
);

CREATE TABLE towns (
    town_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(47)
);



--02. Alter Minions Table - Before continuing with the next assignments, rename the town_id to id using Workbench's GUI.
-- Do not submit this query on the Judge System.
-- Change the structure of the Minions table to have new column town_id that would be of the same type as the id
-- column of towns table. Add new constraint that makes town_id foreign key and references to id column of towns
-- table. Submit your create table query in Judge as MySQL run skeleton, run queries & check DB

ALTER TABLE minions ADD COLUMN town_id int;
ALTER TABLE minions ADD CONSTRAINT fk_minions_town
FOREIGN KEY minions (town_id)
REFERENCES towns(id);



-- 03. Insert Records in Both Tables - Populate both tables with sample records given in the table below.

-- minions                        towns
-- id name   age town_id          id name
-- 1 Kevin   22    1              1 Sofia
-- 2 Bob     15    3              2 Plovdiv
-- 3 Steward NULL  2              3 Varna

-- Use only insert SQL queries. Submit your INSERT statements in Judge as Run skeleton, run queries & check DB.

INSERT INTO towns(id, name) 
VALUES 
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');
INSERT INTO minions (id, name, age, town_id) 
VALUES 
(1, 'Kevin', 22, 1), 
(2, 'Bob', 15, 3), 
(3, 'Steward', NULL, 2);



-- 04. Truncate Table Minions - Delete all the data from the minions table using SQL query. Submit your query in Judge as Run skeleton, run
-- queries & check DB.

TRUNCATE table minions;



-- 05. Drop All Tables - Delete all tables from the minions database using SQL query. Submit your query in Judge as Run skeleton, run
-- queries & check DB.

DROP TABLE `minions`.`minions`, `minions`.`towns`;



-- 06. Create Table People - Using SQL query create table "people" with columns:
-- • id – unique number for every person there will be no more than 231-1people. (Auto incremented)
-- • name – full name of the person will be no more than 200 Unicode characters. (Not null)
-- • picture – image with size up to 2 MB. (Allow nulls)
-- • height – In meters. Real number precise up to 2 digits after floating point. (Allow nulls)
-- • weight – In kilograms. Real number precise up to 2 digits after floating point. (Allow nulls)
-- • gender – Possible states are m or f. (Not null)
-- • birthdate – (Not null)
-- • biography – detailed biography of the person it can contain max allowed Unicode characters. (Allow nulls)
-- Make id primary key. Popula

CREATE TABLE people (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height DOUBLE(10 , 2 ),
    weight DOUBLE(10 , 2 ),
    gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT
);

insert into people (name, gender, birthdate)
values
    ('Ivan', 'm', DATE(now())),
    ('Pepi', 'f', DATE(now())),
    ('Anton', 'm', DATE(now())),
    ('Maya', 'f', DATE(now())),
    ('Gosho', 'm', DATE(now()));



-- 07. Create Table Users - Using SQL query create table users with columns:
-- • id – unique number for every user. There will be no more than 263-1 users. (Auto incremented)
-- • username – unique identifier of the user will be no more than 30 characters (non Unicode). (Required)
-- • password – password will be no longer than 26 characters (non Unicode). (Required)
-- • profile_picture – image with size up to 900 KB.
-- • last_login_time
-- • is_deleted – shows if the user deleted his/her profile. Possible states are true or false.

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB,
    last_login_time DATETIME,
    is_deleted BOOLEAN
);

insert into users (username, password)
values
    ('test', 'test'),
    ('test', 'test'),
    ('test', 'test'),
    ('test', 'test'),
    ('test', 'test');
    
    
    
-- 08. Change Primary Key - Using SQL queries modify table users from the previous task. First remove current primary key then create new
-- primary key that would be combination of fields id and username. The initial primary key name on id is pk_users.
-- Submit your query in Judge as Run skeleton, run queries & check DB.

ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users2
PRIMARY KEY users(id, username);


-- 9. Set Default Value of a Field - Using SQL queries modify table users. Make the default value of last_login_time field to be the current time.
-- Submit your query in Judge as Run skeleton, run queries & check DB.

ALTER TABLE users
CHANGE COLUMN last_login_time
last_login_time DATETIME DEFAULT NOW();



-- 10. Set Unique Field - Using SQL queries modify table users. Remove username field from the primary key so only the field id would be
-- primary key. Now add unique constraint to the username field. The initial primary key name on (id, username) is
-- pk_users. Submit your query in Judge as Run skeleton, run queries & check DB.

ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY users(id),
CHANGE COLUMN username
username VARCHAR(30) UNIQUE;



-- 11. Movies Database - Using SQL queries create Movies database with the following entities:
-- • directors (id, director_name, notes)
-- o director_name cannot be null
-- © SoftUni – about.softuni.bg. Copyrighted document. Unauthorized copy, reproduction or use is not permitted.
--  Follow us: Page 3 of 4
-- • genres (id, genre_name, notes)
-- o genre_name cannot be null
-- • categories (id, category_name, notes)
-- o category_name cannot be null
-- • movies (id, title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
-- o title cannot be null
-- Set most appropriate data types for each column. Set primary key to each table. Populate each table with 5
-- records. Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields
-- are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries &
-- check DB.

CREATE TABLE directors (
  id INT PRIMARY KEY,
  director_name VARCHAR(100) NOT NULL,
  notes VARCHAR(255)
);
INSERT INTO directors (id, director_name, notes)
VALUES
  (1, 'Christopher Nolan', 'Acclaimed filmmaker known for mind-bending narratives.'),
  (2, 'Steven Spielberg', 'Renowned director of blockbuster movies.'),
  (3, 'Quentin Tarantino', 'Master of dialogue and nonlinear storytelling.'),
  (4, 'Martin Scorsese', 'Iconic director of crime dramas.'),
  (5, 'Sofia Coppola', 'Award-winning director with a unique artistic style.');
CREATE TABLE genres (
  id INT PRIMARY KEY,
  genre_name VARCHAR(100) NOT NULL,
  notes VARCHAR(255)
);
INSERT INTO genres (id, genre_name, notes)
VALUES
  (1, 'Action', 'Movies involving thrilling action sequences.'),
  (2, 'Drama', 'Character-driven stories with emotional depth.'),
  (3, 'Comedy', 'Movies that aim to entertain through humor.'),
  (4, 'Sci-Fi', 'Fictional movies with scientific or futuristic elements.'),
  (5, 'Romance', 'Movies centered around love and relationships.');
CREATE TABLE categories (
  id INT PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  notes VARCHAR(255)
);
INSERT INTO categories (id, category_name, notes)
VALUES
  (1, 'Feature Film', 'Full-length movies intended for theatrical release.'),
  (2, 'Documentary', 'Non-fictional movies that explore real-life subjects.'),
  (3, 'Animated', 'Movies featuring animated characters or visuals.'),
  (4, 'Short Film', 'Brief movies typically less than 40 minutes in length.'),
  (5, 'Thriller', 'Suspenseful movies that keep audiences on the edge of their seats.');
CREATE TABLE movies (
  id INT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  director_id INT,
  copyright_year INT,
  length INT,
  genre_id INT,
  category_id INT,
  rating DECIMAL(3, 1),
  notes VARCHAR(255)
);
INSERT INTO movies (id, title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
VALUES
  (1, 'Inception', 1, 2010, 148, 4, 1, 8.8, 'Mind-bending sci-fi heist film.'),
  (2, 'Jurassic Park', 2, 1993, 127, 1, 1, 8.1, 'Classic dinosaur adventure.'),
  (3, 'Pulp Fiction', 3, 1994, 154, 2, 1, 8.9, 'Quirky crime anthology.'),
  (4, 'The Departed', 4, 2006, 151, 5, 1, 8.5, 'Intense undercover cop drama.'),
  (5, 'Lost in Translation', 5, 2003, 102, 2, 1, 7.7, 'Intense undercover cop drama.');
  
  

-- 12. Car Rental Database - Using SQL queries create car_rental database with the following entities:
-- • categories (id, category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
-- • cars (id, plate_number, make, model, car_year, category_id, doors, picture, car_condition,
-- available)
-- • employees (id, first_name, last_name, title, notes)
-- • customers (id, driver_licence_number, full_name, address, city, zip_code, notes)
-- • rental_orders (id, employee_id, customer_id, car_id, car_condition, tank_level,
-- kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date,
-- total_days, rate_applied, tax_rate, order_status, notes)
-- Set most appropriate data types for each column. Set primary key to each table. Populate each table with 3
-- records. Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields
-- are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries &
-- check DB.


-- 13. Basic Insert - Now create bigger database called soft_uni. You will use database in the future tasks. It should hold information
-- about
--  • towns (id, name)
--  • addresses (id, address_text, town_id)
--  • departments (id, name)
--  • employees (id, first_name, middle_name, last_name, job_title, department_id, hire_date, salary, address_id)
-- Id columns are auto incremented starting from 1 and increased by 1 (1, 2, 3, 4…). Make sure you use appropriate
-- data types for each column. Add primary and foreign keys as constraints for each table. Use only SQL queries.
-- Consider which fields are always required and which are optional.
-- Do not submit creation of database only the insert statements.
-- Use the SoftUni database and insert some data using SQL queries.
-- © SoftUni – about.softuni.bg. Copyrighted document. Unauthorized copy, reproduction or use is not permitted.
--  Follow us: Page 4 of 4
-- • towns: Sofia, Plovdiv, Varna, Burgas
-- • departments: Engineering, Sales, Marketing, Software Development, Quality Assurance
-- • employees:
-- name job_title department hire_date salary
-- Ivan Ivanov Ivanov .NET Developer Software Development 01/02/2013 3500.00
-- Petar Petrov Petrov Senior Engineer Engineering 02/03/2004 4000.00
-- Maria Petrova Ivanova Intern Quality Assurance 28/08/2016 525.25
-- Georgi Terziev Ivanov CEO Sales 09/12/2007 3000.00
-- Peter Pan Pan Intern Marketing 28/08/2016 599.88
-- Submit your INSERT queries in Judge as Run skeleton, run queries & check DB.


-- 14. Basic Select All Fields - Use the soft_uni database and first select all records from the towns, then from departments and finally from
-- employees table. Use SQL queries and submit them to Judge at once. Submit your query statements as Prepare DB
-- & Run queries.

SELECT *
FROM towns;
SELECT *
FROM departments;
SELECT *
FROM employees;



-- 15. Basic Select All Fields and Order Them - Modify queries from previous problem by sorting:
-- • towns - alphabetically by name
-- • departments - alphabetically by name
-- • employees - descending by salary
-- Submit your query statements as Prepare DB & Run queries.

SELECT *
FROM towns AS t
ORDER BY t.name;
SELECT *
FROM departments AS d
ORDER BY d.name;
SELECT *
FROM employees AS e
ORDER BY e.salary DESC;



-- 16. Basic Select Some Fields - Modify queries from previous problem to show only some of the columns. For table:
-- • towns – name
-- • departments – name
-- • employees – first_name, last_name, job_title, salary
-- Keep the ordering from the previous problem. Submit your query statements as Prepare DB & Run queries.

SELECT t.name
FROM towns AS t
ORDER BY t.name;
SELECT d.name
FROM departments AS d
ORDER BY d.name;
SELECT e.first_name, e.last_name, e.job_title, e.salary
FROM employees AS e
ORDER BY e.salary DESC;



-- 17. Increase Employees Salary - Use softuni database and increase the salary of all employees by 10%. Then select only salary column from the
-- employees table. Submit your query statements as Prepare DB & Run queries.

UPDATE employees AS e
SET salary = salary*1.1;
SELECT salary
FROM employees;
