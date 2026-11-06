--CASE
--    WHEN condition1 THEN result1
--    WHEN condition2 THEN result2
--    WHEN conditionN THEN resultN
--    ELSE result
--END;

USE harmash;

CREATE TABLE students (
    id   INT IDENTITY NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    math INT
);
INSERT INTO students VALUES ( 'Ahmad', 82);
INSERT INTO students VALUES ( 'Rami', 87);
INSERT INTO students VALUES ( 'Said', 73);
INSERT INTO students VALUES ( 'Noura', 92);
INSERT INTO students VALUES ( 'Amani', 78);
INSERT INTO students VALUES ( 'Mhamad', 65);
INSERT INTO students VALUES ( 'Ahmad', 45);
INSERT INTO students VALUES ( 'Mostafa', 95);
INSERT INTO students VALUES ( 'Jana', 68);
INSERT INTO students VALUES ( 'Houssam', 120);


SELECT id , name ,
    CASE               -- Bedingungen für die Anzeige der dritten Spalte festlegen
        WHEN math BETWEEN 60 AND 100 THEN 'Bestanden'   -- Bei einem Wert zwischen 60 und 100: 'Passed'
        WHEN math BETWEEN 0  AND 59  THEN 'durchgefallen'   -- Bei einem Wert zwischen 0 und 59: 'Failed'
        ELSE 'An Professor wenden'                    -- Bei allen anderen Werten: 'An Professor wenden' 
    END AS 'Math Noten'                               -- Spaltennamen ändern
FROM students;

SELECT id, name, math AS 'Math (Percent)',
    CASE
        WHEN math BETWEEN 91 AND 100 THEN 'A'
        WHEN math BETWEEN 81 AND 90  THEN 'B'
        WHEN math BETWEEN 70 AND 79  THEN 'C' 
        WHEN math BETWEEN 60 AND 69  THEN 'D'
        WHEN math BETWEEN 0  AND 59  THEN 'E' 
        ELSE 'wenden an Professor'  
    END AS 'Math (Letter)' 
FROM students; 


--UNIQUE stellt sicher, dass jeder Wert in einer Spalte nur einmal vorkommt.
DROP TABLE IF EXISTS users;
GO
CREATE TABLE users (
    id         INT NOT NULL PRIMARY KEY IDENTITY,
    username   VARCHAR(50),
    country  VARCHAR(100),
    UNIQUE(username)       -- UNIQUE-Constraint für die Spalte username hinzufügen
);
--oder
DROP TABLE IF EXISTS users;
GO
CREATE TABLE users (
    id         INT NOT NULL PRIMARY KEY IDENTITY,
    username   VARCHAR(50) ,
    country  VARCHAR(100)
);

SELECT * FROM users;

--aber wenndie Tabelle bereits existiert dann :
ALTER TABLE users 
ADD CONSTRAINT un_name_users UNIQUE (username);

--beispeil dazu
SELECT * FROM Worker;
ALTER TABLE Worker 
ADD CONSTRAINT uniq_Workername UNIQUE (username);

INSERT INTO Worker 
VALUES ('rami','male','Germany',900) 
--Fehlermeldung ,der Name 'rami' existiert bereits einmal und darf gleiche Werte sich nicht wiederholen.


--rename the 'namen' from products.
EXEC sp_rename 'products.namen','nachnamen','COLUMN';--aber hab nich ausgeführt.