-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:

USE ProjektDB;
-- ==================
-- Aggregatfunktionen
-- ==================

-- Aufgabe 4.1
--
-- Nennen Sie die kleinste Personalnummer der Mitarbeiter.
SELECT MIN(id) AS minimum
FROM Mitarbeiter;
--      minimum
--		-------
--      2581


SELECT * FROM Projekt;
-- Aufgabe 4.2
--
-- Berechnen Sie die Summe der finanziellen Mittel aller Projekte.
SELECT SUM(mittel) AS summe  
FROM Projekt;
--      summe
--		---------
--      655000,00



-- Aufgabe 4.3
--
-- Berechnen Sie den arithmetischen Mittelwert der Geldbeträge, 
-- die höher als 92336,10 Euro sind.
SELECT AVG(mittel) AS durchschnitt
FROM Projekt
WHERE mittel >92336.10;

--      durchschnitt
--		------------
--      141625,00



-- Aufgabe 4.4
--
-- Ermitteln Sie den höchsten, einzelnen Umsatz, der bisher erzielt wurde.
SELECT MAX(umsatz) AS umsatz
FROM Umsatz;
--      umsatz
--		---------
--      150000,00



-- Aufgabe 4.5
--
-- Ermitteln Sie den kleinsten, einzelnen Umsatz, der im Jahr 2018 erzielt wurde.
SELECT MIN(umsatz) AS umsatz
FROM Umsatz
WHERE datum BETWEEN '20180101' AND '20181231';
--		umsatz
--		------
--		500,00





