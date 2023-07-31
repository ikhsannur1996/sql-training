-- Step 1: Create a new database (if it doesn't exist) and connect to it
-- Description: This step creates a new database named 'sales' if it doesn't already exist and connects to it.
DROP DATABASE IF EXISTS sales;
CREATE DATABASE sales;

-- Connect to the newly created database
\c sales;

-- Step 2: Creating Tables
-- Description: This step creates two tables, 'employees' and 'products', to store employee and product information, respectively.
DROP table  IF EXISTS employees;
CREATE TABLE IF NOT EXISTS employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    department VARCHAR(100),
    email VARCHAR(100)
);
DROP table  IF EXISTS products;
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price NUMERIC(10, 2),
    stock_quantity INT,
    department VARCHAR(100)
);

-- Step 3: Inserting Data
-- Description: This step inserts sample data into the 'employees' and 'products' tables.
INSERT INTO employees (first_name, last_name, age, department, email)
VALUES
    ('John', 'Doe', 30, 'HR', 'john.doe@example.com'),
    ('Jane', 'Smith', 25, 'Marketing', 'jane.smith@example.com'),
    ('Michael', 'Johnson', 35, 'Sales', 'michael.johnson@example.com'),
    ('David', 'Lee', 28, 'HR', 'david.lee@example.com'),
    ('Mary', 'Williams', 40, 'Sales', 'mary.williams@example.com'),
    ('Laura', 'Jones', 33, 'Marketing', 'laura.jones@example.com'),
    ('Robert', 'Brown', 22, 'Sales', 'robert.brown@example.com'),
    ('Susan', 'Taylor', 45, 'HR', 'susan.taylor@example.com'),
    ('William', 'Clark', 29, 'Marketing', 'william.clark@example.com'),
    ('Sophia', 'Thomas', 37, 'Sales', 'sophia.thomas@example.com');
   
INSERT INTO products (product_name, price, stock_quantity, department)
VALUES
    ('Widget A', 19.99, 100, 'HR'),
    ('Widget B', 24.99, 75, 'Marketing'),
    ('Gadget X', 49.99, 50, 'HR'),
    ('Gadget Y', 39.99, 80, 'Sales'),
    ('Thing Z', 9.99, 120, 'HR'),
    ('Widget C', 34.99, 60, 'Marketing'),
    ('Gadget M', 59.99, 30, 'Marketing'),
    ('Widget D', 14.99, 200, 'Marketing'),
    ('Gadget P', 29.99, 90, 'HR'),
    ('Thing Q', 6.99, 150, 'Sales');

-- Step 4: Updating Data
-- Description: This step updates data in the 'employees' and 'products' tables.
-- Explanation: It updates the department of an employee with id = 1 to 'Finance'.
UPDATE employees
SET department = 'Finance'
WHERE id = 1;

-- Explanation: It updates the price of 'Widget A' to 29.99.
UPDATE products
SET price = 29.99
WHERE product_name = 'Widget A';

-- Step 5: Deleting Data
-- Description: This step deletes data from the 'employees' and 'products' tables.
-- Explanation: It deletes the employee with id = 3 from the 'employees' table.
DELETE FROM employees
WHERE id = 3;

-- Explanation: It deletes products with stock quantity less than or equal to 0 from the 'products' table.
DELETE FROM products
WHERE stock_quantity <= 0;

-- Step 6: Using WHERE Clause
-- Description: This step demonstrates the use of the WHERE clause to filter data.
-- Explanation: It queries the 'employees' table to get all employees who belong to the 'Sales' department and are older than 25.
SELECT first_name, last_name, age
FROM employees
WHERE department = 'Sales' AND age > 25;

-- Explanation: It queries the 'products' table to get all products with a price higher than 30.
SELECT product_name, price
FROM products
WHERE price > 30;

-- Step 7: Using GROUP BY and Aggregate Functions
-- Description: This step demonstrates grouping data using GROUP BY and calculating aggregate functions.
-- Explanation: It groups data from the 'employees' table by 'department' and calculates the total 'stock_quantity' for each department.
SELECT department, AVG(age) AS average_age
FROM employees
GROUP BY department
ORDER BY average_age DESC; -- Order the results by total_age in descending order

-- Explanation: It groups data from the 'products' table by 'department' and calculates the average 'price' for each department.
SELECT department, AVG(price) AS average_price
FROM products
GROUP BY department;

-- Step 8: Using ORDER BY
-- Description: This step demonstrates sorting data using ORDER BY.
-- Explanation: It queries the 'employees' table and orders the results by 'age' in descending order.
SELECT first_name, last_name, age
FROM employees
ORDER BY age DESC;

-- Explanation: It queries the 'products' table and orders the results by 'price' in ascending order.
SELECT product_name, price
FROM products
ORDER BY price ASC;

-- Step 10: Using LIMIT and OFFSET
-- Description: This step demonstrates the use of LIMIT and OFFSET for pagination.
-- Explanation: It queries the 'products' table and gets the top 5 most expensive products.
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- Explanation: It queries the 'products' table and gets products ranked 6 to 10 in terms of price.
SELECT product_name, price
FROM products
ORDER BY price DESC
OFFSET 5 LIMIT 5;

-- Step 10: Using JOIN
-- Description: This step demonstrates performing joins between 'employees' and 'products' tables based on the 'department' column.
-- Explanation: It performs an inner join between the 'employees' and 'products' tables to get employees along with the products they are responsible for.
SELECT employees.first_name, employees.last_name, employees.age, products.product_name, products.price
FROM employees
JOIN products ON employees.department = products.department;

-- Step 11: Using Subqueries
-- Description: This step demonstrates the use of subqueries.
-- Explanation: It uses a subquery to get employees from the 'Sales' department with the highest age.
SELECT first_name, last_name, age
FROM employees
WHERE department = 'Sales' AND age = (SELECT MAX(age) FROM employees WHERE department = 'Sales');

-- Explanation: It uses a subquery to get products with a price greater than the average price of all products.
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Step 12: Using LIKE and Wildcards
-- Description: This step demonstrates using LIKE with wildcard characters.
-- Explanation: It queries the 'employees' table to get employees with the first name starting with 'J'.
SELECT first_name, last_name, age
FROM employees
WHERE first_name LIKE 'J%';

-- Explanation: It queries the 'products' table to get products with names containing 'Widget'.
SELECT product_name, price
FROM products
WHERE product_name LIKE '%Widget%';

-- Step 13: Using CASE statement
-- Description: This step demonstrates using the CASE statement to create conditional expressions.
-- Explanation: It queries the 'employees' table and categorizes employees into age groups ('Young', 'Middle-aged', 'Senior') based on their age.
SELECT first_name, age,
  CASE
    WHEN age <= 30 THEN 'Young'
    WHEN age > 30 AND age <= 50 THEN 'Middle-aged'
    ELSE 'Senior'
  END AS age_group
FROM employees;

-- Step 14: Using DELETE, UPDATE, and TRUNCATE
-- Description: This step demonstrates data deletion and updating.
-- Explanation: It deletes employees from the 'HR' department who are older than 40.
DELETE FROM employees
WHERE department = 'HR' AND age > 40;

-- Explanation: It updates product prices by applying a 10% discount.
UPDATE products
SET price = price * 0.9

-- Note: TRUNCATE is not supported in PostgreSQL.
-- Instead, delete all rows from the 'employees' table without actually deleting the table itself.
DELETE FROM employees;

-- Step 16: Using ORDER BY and GROUP BY
-- Description: This step demonstrates using ORDER BY and GROUP BY together.
-- Explanation: It queries the 'employees' table and orders the results by 'age' in ascending order and then by 'department' in descending order.
SELECT first_name, last_name, age
FROM employees
ORDER BY age ASC, department DESC;

-- Explanation: It groups data from the 'products' table by 'department' and calculates the total 'stock_quantity' for each department.
-- Only show the results for departments with total stock greater than 100.
SELECT department, SUM(stock_quantity) AS total_stock
FROM products
GROUP BY department
HAVING SUM(stock_quantity) > 100
ORDER BY total_stock DESC;

-- Step 17: Using Common Table Expressions (CTEs)
-- Description: This step demonstrates the use of Common Table Expressions (CTEs).
-- Explanation: It creates a CTE to get employees from the 'Marketing' department.
WITH marketing_employees AS (
  SELECT *
  FROM employees
  WHERE department = 'Marketing'
)
-- Explanation: It queries the CTE to get employees from the 'Marketing' department who are younger than 30.
SELECT first_name, last_name, age
FROM marketing_employees
WHERE age < 30;

-- Step 18: Additional Aggregating Examples
-- Description: This step demonstrates additional examples of using aggregate functions.
-- Explanation: It calculates the total price and average price of all products.
SELECT SUM(price) AS total_price, AVG(price) AS average_price
FROM products;

-- Explanation: It finds the highest and lowest price of products.
SELECT MAX(price) AS highest_price, MIN(price) AS lowest_price
FROM products;

-- Explanation: It calculates the total stock quantity for all products.
SELECT SUM(stock_quantity) AS total_stock
FROM products;

-- Step 19: Using GROUP BY and HAVING with Aggregates
-- Description: This step demonstrates using GROUP BY and HAVING with aggregate functions.
-- Explanation: It finds departments that have more than 2 employees and their average age is greater than 25.
SELECT department, COUNT(*) AS num_employees, AVG(age) AS average_age
FROM employees
GROUP BY department
HAVING COUNT(*) > 2 AND AVG(age) > 25;

-- Step 20: Using DISTINCT with Aggregate Functions
-- Description: This step demonstrates using DISTINCT with aggregate functions.
-- Explanation: It finds unique department names along with the number of employees in each department.
SELECT department, COUNT(DISTINCT id) AS num_employees
FROM employees
GROUP BY department;

-- Step 21: Using CONCAT to combine first_name and last_name into a full_name column
-- Explanation: It concatenates the 'first_name' and 'last_name' columns to create a new column 'full_name'.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

-- Step 22: Using LENGTH to calculate the length of product_name for all products
-- Explanation: It calculates the length of the 'product_name' for each product in the 'products' table.
SELECT product_name, LENGTH(product_name) AS name_length
FROM products;

-- Step 23: Using UPPER and LOWER to convert product_name to uppercase and lowercase, respectively
-- Explanation: It converts the 'product_name' to uppercase and lowercase for each product in the 'products' table.
SELECT product_name, UPPER(product_name) AS uppercase_name, LOWER(product_name) AS lowercase_name
FROM products;

-- Step 24: Using LEFT and RIGHT to retrieve the first three characters and last two characters of product_name
-- Explanation: It retrieves the first three characters and last two characters of 'product_name' for each product in the 'products' table.
SELECT product_name, LEFT(product_name, 3) AS first_three_chars, RIGHT(product_name, 2) AS last_two_chars
FROM products;

-- Step 25: Using SUBSTRING to get a substring from product_name starting at position 8 and taking 5 characters
-- Explanation: It extracts a substring from 'product_name' for each product in the 'products' table, starting at position 8 and taking 5 characters.
SELECT product_name, SUBSTRING(product_name FROM 8 FOR 5) AS substring_name
FROM products;

-- Step 26: Using REPLACE to replace 'Widget' with 'Gadget' in product_name
-- Explanation: It replaces occurrences of 'Widget' with 'Gadget' in the 'product_name' for each product in the 'products' table.
SELECT product_name, REPLACE(product_name, 'Widget', 'Gadget') AS replaced_name
FROM products;

-- Step 27: Using TRIM to remove leading and trailing spaces from email addresses
-- Explanation: It removes leading and trailing spaces from the 'email' column for each employee in the 'employees' table.
SELECT email, TRIM(email) AS trimmed_email
FROM employees;

-- Step 28: Using POSITION to find the position of '@' in email addresses
-- Explanation: It finds the position of the character '@' in the 'email' column for each employee in the 'employees' table.
SELECT email, POSITION('@' IN email) AS at_position
FROM employees;

-- Conclusion
-- This SQL script covers a variety of SQL operations in PostgreSQL, including table creation, data manipulation, filtering, grouping, aggregation, and string functions.
-- Understanding these SQL concepts will empower you to work with databases effectively and perform complex queries.
