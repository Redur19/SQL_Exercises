-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen

USE ProjektDB;

-- Aufgabe 2.1
--
-- Finden Sie Namen und Personalnummer aller Mitarbeiter, 
-- deren Name mit dem Buchstaben "K" beginnt.

SELECT nachname , id
FROM Mitarbeiter
WHERE nachname LIKE 'K%' ;
--      nachname  id
--      Kaufmann  2581
--      Krüger    17000
--      Keller    25348



-- Aufgabe 2.2
--
-- Nennen Sie Namen, Vornamen und Id aller Mitarbeiter, 
-- deren Vorname als zweiten Buchstaben ein "a" hat.

SELECT nachname ,vorname, id
FROM Mitarbeiter
WHERE vorname LIKE '_a%' ;

--      nachname  vorname   id
--      Schäfer   Sabine    5765
--      Meier     Rainer    9031
--      Krüger    Martin    17000
--      Müller    Gabriele  18316
--      Keller    Hans      25348



-- Aufgabe 2.3
--
-- Finden Sie Abteilungs-Id und Standort aller Abteilungen, die 
-- sich in den Orten befinden, die mit einem Buchstaben zwischen 
-- "N" und "Z" beginnen.

SELECT *FROM Abteilung;
SELECT id, ort 
FROM Abteilung
WHERE ort LIKE '[N-Z]%' ;

--      id  ort
--      3   Stuttgart
--      5   Ulm



-- Aufgabe 2.4
--
-- Finden Sie Id, Nachnamen und Vornamen aller Mitarbeiter, deren 
-- Namen nicht mit den Buchstaben K, L, M, N, O und P beginnen,
-- und deren Vornamen nicht mit dem Buchstaben U beginnen.

SELECT id, nachname ,vorname
FROM Mitarbeiter
--oderWHERE nachname LIKE '[^K-P]%' AND vorname LIKE '[^u]%' ;
 WHERE nachname LIKE '[^KLMNOP]%' AND vorname NOT LIKE 'u%' ;
--      id     nachname  vorname
--      5765   Schäfer   Sabine
--      9912   Wolf      Klaus
--      10102  Huber     Petra
--      20204  Fuchs     Dirk
--      22222  Vogel     Anke
--      24321  Schubert  Rolf
--      27365  Albrecht  Lena



-- Aufgabe 2.5
--
-- Nennen Sie Vor- und Nachname aller Mitarbeiter, deren Name 
-- nicht mit "er" endet.

SELECT vorname, nachname 
FROM Mitarbeiter
WHERE nachname NOT LIKE '%er' ;

--      vorname   nachname
--      Brigitte  Kaufmann
--      Klaus     Wolf
--      Dirk      Fuchs
--      Anke      Vogel
--      Rolf      Schubert
--      Lena      Albrecht
--      Andreas   Probst



-- Aufgabe 2.6
--
-- Wie kann man nach dem Unterstrich (_) oder dem Prozentzeichen (%)
-- mit LIKE suchen? Finden Sie alle Kunden, in deren Datensatz ein 
-- solches Sonderzeichen vorkommt.

SELECT * FROM Kunde
WHERE id LIKE '%[%_]%'
   OR firma LIKE '%[%_]%'
   OR ort LIKE '%[%_]%';

--      firma                  stadt
--      100% Sonderzeichen AG  Baden_Baden



-- Aufgabe 2.7
--
-- Nennen Sie alle Mitarbeiter, deren Vorname mindestens 
-- drei Vokale enthält.

SELECT *
FROM Mitarbeiter
WHERE vorname LIKE '%[aeiou]%[aeiou]%[aeiou]%' ;


--      id     vorname   nachname  abt_id  ort        chef_id
--      2581   Brigitte  Kaufmann  2       NULL       NULL
--      5765   Sabine    Schäfer   3       Landshut   2581
--      9031   Rainer    Meier     2       NULL       2581
--      12121  Ursula    Richter   4       München    22222
--      18316  Gabriele  Müller    1       Rosenheim  2581
--      28559  Sibille   Mozer     1       Ulm        2581
--      29346  Andreas   Probst    2       Augsburg   2581



-- Aufgabe 2.8
-- 
-- Finden Sie alle Mitarbeiter, deren Vorname aus genau sieben
-- Buchstaben besteht.

SELECT *
FROM Mitarbeiter
WHERE  LEN(vorname) = 7 ;
--or
SELECT *
FROM Mitarbeiter
WHERE  vorname LIKE  '[a-z][a-z][a-z][a-z][a-z][a-z][a-z]' ;
--or
SELECT *
FROM Mitarbeiter
WHERE  vorname LIKE  '_______' ;
--      id     vorname  nachname  abt_id  ort       chef_id
--      28559  Sibille  Mozer     1       Ulm       2581
--      29346  Andreas  Probst    2       Augsburg  2581



-- Aufgabe 2.9
--
-- Finden Sie alle Mitarbeiter, deren Vorname aus genau sechs
-- Buchstaben besteht und deren Vorname nicht mit einem Vokal endet.

SELECT *
FROM Mitarbeiter
WHERE  vorname LIKE  '[a-z][a-z][a-z][a-z][a-z][a-z]'  AND vorname LIKE '%[^aeiüöou]' ;
--or 
SELECT *
FROM Mitarbeiter
WHERE  LEN(vorname) = 6  AND vorname LIKE '%[^aeiüöou]' ;
--      id     vorname  nachname  abt_id  ort    chef_id
--      9031   Rainer   Meier     2       NULL   2581
--      17000  Martin   Krüger    5       Ulm    22222



-- Aufgabe 2.10
--
-- Finden Sie alle Mitarbeiter, bei deren Vorname der vorletzte
-- Buchstabe ein Vokal ist.

SELECT *
FROM Mitarbeiter
WHERE  vorname LIKE  '%[aeiäöüou]_';

--      id     vorname  nachname  abt_id  ort         chef_id
--      9031   Rainer   Meier     2       NULL        2581
--      9912   Klaus    Wolf      4       Heidenheim  22222
--      17000  Martin   Krüger    5       Ulm         22222
--      29346  Andreas  Probst    2       Augsburg    2581


