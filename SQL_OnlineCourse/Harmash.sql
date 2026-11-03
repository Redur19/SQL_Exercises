--Test
DROP DATABASE IF EXISTS harmash;

CREATE DATABASE harmash;

CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY IDENTITY,
    username VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO users (username, email) VALUES ('mhamad', 'mhamad@example.com');
INSERT INTO users (username, email) VALUES ('hassan', 'hassan@example.com');
INSERT INTO users (username, email) VALUES ('sara', 'sara@example.com');
INSERT INTO users (username, email) VALUES ('rami', 'rami@example.com');
INSERT INTO users (username, email) VALUES ('maria', 'maria@example.com');

SELECT * FROM users;
USE ProjektDB
--Neuer Test

DROP DATABASE IF EXISTS harmash;
GO
CREATE DATABASE harmash;
GO
USE harmash;


CREATE TABLE employees (
    id         INT NOT NULL PRIMARY KEY IDENTITY,
    first_name VARCHAR(50),
    last_name  VARCHAR(20),
    is_married BIT,
    salary     DECIMAL(7,2),
    birthday   Date
);

INSERT INTO employees VALUES ( 'Ahmad', 'Alhazem', 0, 800, '1990-10-23');
INSERT INTO employees VALUES ( 'Rami', 'Algharib', 0, 750, '1992-05-08');
INSERT INTO employees VALUES (  'Said', 'Alnaja', 1, 900, '1988-07-12');
INSERT INTO employees VALUES ( 'Noura', 'Jamali', 0, 845, '1994-12-04');
INSERT INTO employees VALUES ( 'Amani', 'Sarrouf', 1, 1000, '1991-10-27');
INSERT INTO employees VALUES ( 'Mhamad', 'Harmush', 0, 700, '1993-11-12');
INSERT INTO employees VALUES ( 'Ahmad', 'Asaadi', 1, 850, '1995-03-10');
INSERT INTO employees VALUES ('Mostafa', 'Shawki', 1, 920, '1990-02-14');
INSERT INTO employees VALUES ( 'Jana', 'Alkassem', 0, 780, '1991-08-12');
INSERT INTO employees VALUES ( 'Houssam', 'Zahrani', 1, 880, '1985-09-20');

SELECT first_name, last_name, salary
FROM employees;
SELECT *
FROM employees;

SELECT first_name AS First_Name, last_name AS 'Last Name', salary AS 'Salary'
FROM employees;

--neue Tabelle
CREATE TABLE employees2 (
    id         INT NOT NULL PRIMARY KEY IDENTITY,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    salary     DECIMAL(7,2)
);

INSERT INTO employees2 VALUES ( 'Ahmad', 'Alhazem', 800);
INSERT INTO employees2 VALUES ( 'Rami', 'Algharib', 750);
INSERT INTO employees2 VALUES ( 'Said', 'Alnaja', 900);
INSERT INTO employees2 VALUES ( 'Noura', 'Jamali', 845);
INSERT INTO employees2 VALUES ( 'Amani', 'Sarrouf', 1000);
INSERT INTO employees2 VALUES ( 'Mhamad', 'Harmush', 700);
INSERT INTO employees2 VALUES ( 'Ahmad', 'Asaadi', 850);
INSERT INTO employees2 VALUES ( 'Mostafa', 'Shawki', 920);
INSERT INTO employees2 VALUES ( 'Jana', 'Alkassem', 780);
INSERT INTO employees2 VALUES ( 'Houssam', 'Zahrani', 880);

SELECT
    --CONCAT(first_name, ' ', last_name) AS Employee,
    (first_name+ ' '+ last_name) AS Employee,
    CONCAT(salary, ' $') AS 'Salary.'
FROM employees2
WHERE salary >= 800
ORDER BY salary ;--aufsteigend

SELECT * FROM employees2
WHERE first_name LIKE '[AM]%' --hier der Name muss mit A oder M anfangen
ORDER BY first_name DESC; --absteigend



CREATE TABLE products (
    id    INT NOT NULL PRIMARY KEY IDENTITY,
    namen  VARCHAR(50),
    price DECIMAL(7,2)
);
GO
INSERT INTO products VALUES ( 'Keyboard', 15.00);
INSERT INTO products VALUES ( 'Camera', 44.99);
INSERT INTO products VALUES ( 'HDD 1TB', 70.00);
INSERT INTO products VALUES ( 'SSD 1TB', 274.66);
INSERT INTO products VALUES ( 'Mouse', 8.50);
INSERT INTO products VALUES ( 'Table', 44.55);

SELECT 
    name AS produkt,                            -- Produktname
    price AS 'Price ($)',                         -- Netto Preis
    price * 0.1 AS 'Tax ($)',                     -- 10% Steuer
    price + (price * 0.1) AS 'Final Price ($)'    -- Brutto Preis 
FROM products

--rename the 'name' from products.
EXEC sp_rename 'products.namen','nachnamen','COLUMN';

--FROMAT, wie viele Ziffern sollen nach dem Komma angezeigt werden.
SELECT nachname AS Produkt,
        price AS 'Price ($)',
        FORMAT(price * 0.9, '0.00') AS 'Price (€)',
        FORMAT(price * 1500, '0') AS 'Price (LL)',
        FORMAT(price * 3.75, '0.0') AS 'Price (SAR)'
FROM products;

SELECT * FROM employees2
WHERE salary>=800;


CREATE TABLE Customers (
    id         INT IDENTITY NOT NULL PRIMARY KEY ,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    country    VARCHAR(50)
);
INSERT INTO Customers VALUES ( 'Rami', 'Masri', 'Lebanon');
INSERT INTO Customers VALUES ( 'Ahmad', 'Naji', 'Syria');
INSERT INTO Customers VALUES ( 'Hanan', 'Mostafa', 'KSA');
INSERT INTO Customers VALUES ( 'Saly', 'Harmush', 'Lebanon');
INSERT INTO Customers VALUES ( 'Samir', 'Saleh', 'Lebanon');
INSERT INTO Customers VALUES ( 'Hamad', 'Akel', 'Syria');
INSERT INTO Customers VALUES ( 'Abdullah', 'Helmi', 'Egypt');
INSERT INTO Customers VALUES ( 'Rashed', 'Masri', 'Oman');
INSERT INTO Customers VALUES ( 'Majed', 'Alali', 'Yaman');
INSERT INTO Customers VALUES ( 'Rayan', 'Kasabi', 'KSA');

SELECT * FROM Customers;
BEGIN TRANSACTION;
DELETE FROM Customers WHERE id = 10;   
INSERT INTO Customers VALUES ( 'Max', 'Müller', 'Germany');
SELECT * FROM Customers;

INSERT INTO Customers VALUES ( 'xxx', 'xxx', 'xxx');
UPDATE Customers
SET first_name = 'Sasha',
    last_name = 'Dreibrüder',
    country = 'Germany'
WHERE id = 12;

SELECT TOP(1) salary AS 'Lowest Salary'  --or MAX(salary)
FROM employees2                 
ORDER BY salary DESC;

SELECT salary AS 'Second Highest Salary' 
FROM employees2                                   
ORDER BY salary DESC
OFFSET 1 ROWS
FETCH NEXT 1 ROWS ONLY;

SELECT MIN(salary) AS 'Second Highest Salary' 
FROM employees2                                   
WHERE salary IN ( SELECT TOP(2) salary 
                FROM employees2 
                ORDER BY salary DESC);
