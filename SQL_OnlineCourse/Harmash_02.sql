USE harmash;
--Estellung der Tabellen 
DROP TABLE IF EXISTS employees2;
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

DROP TABLE IF EXISTS employees;
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
SELECT id, username, IIF(country IS NULL, ' Kein Info ',country ) AS 'country'
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
DROP TABLE IF EXISTS Worker;
GO
CREATE TABLE Worker (
    id       INT NOT NULL PRIMARY KEY IDENTITY,
    username VARCHAR(50) NOT NULL,
    gender   VARCHAR(20),
    country  VARCHAR(50),
    salary   DECIMAL(7,2)
);
GO
INSERT INTO Worker VALUES ( 'rami', 'male', 'Lebanon', 700);
INSERT INTO Worker VALUES ( 'ahmad', 'male', 'Syria', 800);
INSERT INTO Worker VALUES ( 'hanan', 'female', 'KSA', 750);
INSERT INTO Worker VALUES ( 'saly', 'female', 'Lebanon', 650);
INSERT INTO Worker VALUES ( 'samir', 'male', 'Egypt', 600);
INSERT INTO Worker VALUES ( 'hamad', 'male', NULL, 700);
INSERT INTO Worker VALUES ( 'abdullah', 'male', 'KSA', 800);
INSERT INTO Worker VALUES ( 'rashed', 'male', 'Oman', 900);
INSERT INTO Worker VALUES ( 'majed', 'male', 'Yaman', 820);
INSERT INTO Worker VALUES ( 'max', 'male', NULL, 1001);

SELECT * FROM Worker

--Anzahl der Mitarbeiter für jedes Land
SELECT country, COUNT(id) AS LandAnzahl
FROM Worker
GROUP BY country;  

--Anzahl der Mitarbeiter nach Geschlecht
SELECT gender, COUNT(id) AS AnzahlMitarbeiter
FROM Worker
GROUP BY gender;

SELECT country, CAST(AVG(salary) AS DECIMAL(10,2)) AS  Durchschnitt_Gehalt
FROM Worker
GROUP BY country;  

SELECT country, SUM(salary) AS [Gehälter eines Landes]  --Statt SUM() können wir auch MIN() oder MAX()
FROM Worker
GROUP BY country;  

SELECT country , COUNT(id) AS 'Anzahl der männlichen Mitarbeiter'
FROM Worker
WHERE gender = 'male'
GROUP BY country;

--GROUP BY country und gender zusammen
SELECT country, gender, COUNT(id) 
FROM Worker
GROUP BY country, gender; 

--HAVING filtert die gruppierten Ergebnisse nach der Anwendung von Aggregatfunktionen.
SELECT country, AVG(salary) AS Durchschnitt 
FROM Worker
GROUP BY country
HAVING AVG(salary) > 800;

SELECT * FROM Worker;
--Erstellen einer Tabelle aus einer anderen Tabelle
SELECT w.* --oder id, username, gender, country, salary 
INTO Worker_Backup
FROM Worker w
WHERE country IS NOT NULL;
SELECT * FROM Worker_Backup;


DROP TABLE Worker_Backup
--Übertragung der Datensätze von einer Tabelle in eine andere existierende Tabelle.
--1. SChritt: CREATE eine Tabelle.
CREATE TABLE Worker_Backup (
    id       INT NOT NULL PRIMARY KEY IDENTITY,
    username VARCHAR(50) NOT NULL,
    gender   VARCHAR(20),
    country  VARCHAR(50),
    salary   DECIMAL(7,2)
);
--dann
INSERT INTO Worker_Backup ( username, gender, country, salary)
SELECT  username, gender, country, salary
FROM Worker;

--ODER, mit ID aber soll wir zuerst IDENTITY manuell aktivieren.
SET IDENTITY_INSERT Worker_Backup ON;
INSERT INTO Worker_Backup (id, username, gender, country, salary)
SELECT  id,username, gender, country, salary
FROM Worker;
SET IDENTITY_INSERT Worker_Backup OFF;

SELECT * FROM Worker_Backup;
