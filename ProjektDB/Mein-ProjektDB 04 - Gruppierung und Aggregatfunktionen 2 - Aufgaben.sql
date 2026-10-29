-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:

USE ProjektDB;
-- ==================================
-- Aggregatfunktionen mit Gruppierung
-- ==================================

-- Aufgabe 4.7
--
-- Finden Sie heraus, wie viele verschiedene Aufgaben in jedem 
-- Projekt ausgeübt werden. Nullwerte sollen nicht gezählt werden!

SELECT * FROM Arbeit;

SELECT pro_id , COUNT(DISTINCT aufgabe) AS anzah 
FROM Arbeit
GROUP BY pro_id;

--      pro_id  anzahl
--      1       3
--      2       1
--      3       3
--      4       3
--      5       2



-- Aufgabe 4.8
--
-- Finden Sie heraus, wieviele Mitarbeiter in jedem Projekt arbeiten.

SELECT pro_id, COUNT(DISTINCT mit_id) AS anzah  --oder ohne DISTINCT
FROM Arbeit
GROUP BY pro_id;

--      pro_id  anzahl
--      1       5
--      2       4
--      3       4
--      4       4
--      5       3



-- Aufgabe 4.9
--
-- Gruppieren Sie die Reihen der Tabelle “Arbeit“ nach den 
-- vorhandenen Aufgaben und zählen Sie die Anzahl der Mitarbeiter 
-- abhängig von der jeweiligen Aufgabe.

SELECT aufgabe, COUNT( DISTINCT mit_id) AS anzahl
FROM Arbeit
GROUP BY aufgabe;


--      aufgabe         anzahl
--      NULL            5
--      Gruppenleiter   3
--      Projektleiter   4
--      Sachbearbeiter  7



-- Aufgabe 4.10
--
-- Wie viele "echte" Aufgaben nehmen die Mitarbeiter wahr,
-- deren Id größer als 20000 ist?

SELECT mit_id , COUNT(aufgabe) AS anzahl
FROM Arbeit
WHERE mit_id >20000 --AND aufgabe IS NOT NULL
GROUP BY mit_id;

--      mit_id  anzahl
--      20204   1
--      22222   1
--      24321   0
--      25348   1
--      27365   1
--      28559   1
--      29346   1

SELECT * FROM Arbeit;

-- Aufgabe 4.11
--
-- Zählen Sie, wie viele Mitarbeiter in jedem Jahr für mindestens
-- ein Projekt eingestellt wurden.
SELECT YEAR(einst_dat) AS jahr, COUNT(DISTINCT mit_id) AS anzahl
FROM Arbeit
GROUP BY YEAR(einst_dat) ;
--im Fall Jahre sind nicht richtig sortiert.
ORDER BY YEAR(einst_dat) ASC;
--      Jahr  Anzahl
--      2017  2
--      2018  8
--      2019  8


