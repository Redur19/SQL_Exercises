--größter Wert
SELECT TOP(1) salary AS 'Lowest Salary'  --or MAX(salary)
FROM employees2                 
ORDER BY salary DESC;

--zweitgrößter Wert
SELECT salary AS 'Second Highest Salary' 
FROM employees2                                   
ORDER BY salary DESC
OFFSET 1 ROWS
FETCH FIRST 1 ROWS ONLY;

SELECT MIN(salary) AS 'Second Highest Salary' 
FROM employees2                                   
WHERE salary IN ( SELECT TOP(2) salary 
                FROM employees2 
                ORDER BY salary DESC);

--erste und yweite
SELECT salary AS 'Salary' 
FROM employees2                                   
ORDER BY salary DESC
OFFSET 0 ROWS
FETCH FIRST 2 ROWS ONLY; --NEXT statt FIRST geht es auch.

OFFSET 2 ROWS           --ab 3. bis 6. 
FETCH NEXT 4 ROWS ONLY; --FIRST statt NEXT geht es auch.


SELECT first_name, last_name, birthday --Älteste ung jungeste 
FROM employees
WHERE birthday IN ((SELECT MIN(birthday) FROM employees), (SELECT MAX(birthday) FROM employees))
ORDER BY birthday;

--NULL , NOT  PRIMARY KEY...
-- 1. Schritt DATABASE harmash löschen falls schon existiert
DROP DATABASE IF EXISTS harmash;

-- harmash DATABASE anlegen
CREATE DATABASE harmash;
GO
USE harmash;

--TABLE users erstellen
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

SELECT * FROM users           -- users ,deren Country nicht NULL ist
WHERE country IS NOT NULL; 


SELECT id, username, ISNULL(country, 'Unknown') AS 'country'
FROM users;-- alle aber wird 'Unknown' satt NULL ausgegeben

