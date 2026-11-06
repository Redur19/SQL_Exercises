--größter Wert
SELECT TOP(1) salary AS 'Lowest Salary'  --or MAX(salary)
FROM employees2                 
ORDER BY salary DESC;
--Älteste 
SELECT MIN(birthday) AS 'Oldest Date'   
FROM employees;

--jungeste
SELECT MAX(birthday) AS 'Oldest Date'   
FROM employees;

--höchste
SELECT MAX(salary) AS 'Highest Salary'  
FROM employees;  
--kleinste 
SELECT MIN(salary) AS 'Highest Salary'  
FROM employees;  

--erste und zweite
SELECT salary AS 'Salary' 
FROM employees2                                   
ORDER BY salary DESC
OFFSET 0 ROWS
FETCH FIRST 2 ROWS ONLY; --NEXT statt FIRST geht es auch.
OFFSET 2 ROWS           --ab 3. bis 6. 
FETCH NEXT 4 ROWS ONLY --FIRST statt NEXT geht es auch.


--zweitgrößter Wert
SELECT salary AS 'Second Highest Salary' 
FROM employees2                                   
ORDER BY salary DESC
OFFSET 1 ROWS
FETCH FIRST 1 ROWS ONLY;
--oder
SELECT MIN(salary) AS 'Second Highest Salary' 
FROM employees2                                   
WHERE salary IN ( SELECT TOP(2) salary 
                FROM employees2 
                ORDER BY salary DESC);


--Älteste ung jungeste 
SELECT first_name, last_name, birthday 
FROM employees
WHERE birthday IN ((SELECT MIN(birthday) FROM employees), (SELECT MAX(birthday) FROM employees))
ORDER BY birthday;

--NULL , NOT  PRIMARY KEY...
--TABLE users erstellen
DROP Table IF EXISTS users;
GO
CREATE TABLE users (
    id       INT NOT NULL PRIMARY KEY IDENTITY,
    username VARCHAR(50) NOT NULL ,
    country  VARCHAR(50) NULL
);

INSERT INTO users VALUES ( 'rami', null);
INSERT INTO users VALUES ( 'ahmad', null);
INSERT INTO users VALUES ( 'hanan', 'KSA');
INSERT INTO users VALUES ( 'saly', 'Lebanon');
INSERT INTO users VALUES ( 'samir', null);
INSERT INTO users VALUES ( 'hamad', 'Syria');
INSERT INTO users VALUES ( 'abdullah', null);
INSERT INTO users VALUES ( 'rashed', 'Oman');
INSERT INTO users VALUES ( 'majed', 'Yaman');
INSERT INTO users VALUES ( 'rayan', null);

-- users ,deren Country nicht NULL ist
SELECT * FROM users           
WHERE country IS NOT NULL; 

-- alle aber wird 'Unknown' satt NULL ausgegeben
SELECT id, username, ISNULL(country, 'Unknown') AS 'country'
FROM users;
--oder 
SELECT id, username, COALESCE(country, 'Unknown') AS 'country'
FROM users;
--oder
SELECT id, username, IIF(country IS  'Unknown',country ) AS 'country'
FROM users;

--AVG
SELECT AVG(salary) AS 'Average Salary'    
FROM employees; 

--CAST format 
SELECT CAST(AVG(salary) AS DECIMAL(10,3)) AS 'Average Salary '   
FROM employees
WHERE is_married = 1;

--Summe aller Gehälter
SELECT SUM(salary) AS 'Total_Salaries '    
FROM employees;

SELECT * FROM employees;

--COUNT 
SELECT COUNT(id) AS [Gesamtzahl der verheirateten Mitarbeiter]   
FROM employees                    
WHERE is_married = 1; 

--DISTINCT: Jeder Wert wird nur einmal angezeigt.
SELECT DISTINCT country
FROM users;

-- GROUP BY
--Tabelle errstellen
DROP TABLE IF EXISTS employees;
GO
CREATE TABLE employees (
    id       INT NOT NULL PRIMARY KEY IDENTITY,
    username VARCHAR(50) NOT NULL,
    gender   VARCHAR(20),
    country  VARCHAR(50),
    salary   DECIMAL(7,2)
);
GO
INSERT INTO employees VALUES ( 'rami', 'male', 'Lebanon', 700);
INSERT INTO employees VALUES ( 'ahmad', 'male', 'Syria', 800);
INSERT INTO employees VALUES ( 'hanan', 'female', 'KSA', 750);
INSERT INTO employees VALUES ( 'saly', 'female', 'Lebanon', 650);
INSERT INTO employees VALUES ( 'samir', 'male', 'Egypt', 600);
INSERT INTO employees VALUES ( 'hamad', 'male', NULL, 700);
INSERT INTO employees VALUES ( 'abdullah', 'male', 'KSA', 800);
INSERT INTO employees VALUES ( 'rashed', 'male', 'Oman', 900);
INSERT INTO employees VALUES ( 'majed', 'male', 'Yaman', 820);
INSERT INTO employees VALUES ( 'max', 'male', NULL, 1001);

SELECT * FROM employees

--Anzahl der Mitarbeiter für jedes Land
SELECT country, COUNT(id) AS LandAnzahl
FROM employees
GROUP BY country;  

--Anzahl der Mitarbeiter nach Geschlecht
SELECT gender, COUNT(id) AS AnzahlMitarbeiter
FROM employees
GROUP BY gender;

SELECT country, CAST(AVG(salary) AS DECIMAL(10,2)) AS  Durchschnitt_Gehalt
FROM employees
GROUP BY country;  

SELECT country, SUM(salary) AS [Gehälter eines Landes]  --Statt SUM() können wir auch MIN() oder MAX()
FROM employees
GROUP BY country;  

SELECT country , COUNT(id) AS 'Anzahl der männlichen Mitarbeiter'
FROM employees
WHERE gender = 'male'
GROUP BY country;

--GROUP BY country und gender zusammen
SELECT country, gender, COUNT(id) 
FROM employees
GROUP BY country, gender; 