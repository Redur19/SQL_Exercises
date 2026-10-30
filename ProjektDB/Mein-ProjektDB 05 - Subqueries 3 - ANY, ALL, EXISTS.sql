-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:

USE ProjektDB
-- ==================
-- ANY / ALL / EXISTS
-- ==================

-- Aufgabe 5.15
-- Finden Sie Personalnummer, Projektnummer und Aufgabe 
-- der Mitarbeiter, deren Projekt-Eintrittsdatum nicht 
-- das letzte ist. Nutzen Sie den ANY-Operator.
--
--      mit_id  aufgabe         einst_dat
--      29346   NULL            2017-12-15
--      20204   Sachbearbeiter  2017-12-20
--      28559   Sachbearbeiter  2018-02-01
--      25348   Sachbearbeiter  2018-02-15
--      28559   NULL            2018-04-15
--      5765    Projektleiter   2018-07-20
--      ...
--      (18 Zeilen)
SELECT mit_id, pro_id, aufgabe, einst_dat -- a.*
FROM Arbeit 
WHERE einst_dat < ANY ( SELECT einst_dat FROM Arbeit)
ORDER BY einst_dat;
--oder aber ohne dieser Operator
SELECT a.*
FROM Arbeit a
WHERE mit_id != (SELECT MAX(mit_id) FROM Arbeit);

-- Aufgabe 5.16
-- Nennen Sie die Aufgabe des Mitarbeiters, der die kleinste 
-- Personalnummer hat. Nutzen Sie den ALL-Operator.
--
--      aufgabe
--      Projektleiter
SELECT aufgabe 
FROM Arbeit 
WHERE mit_id <= ALL (SELECT id FROM Mitarbeiter );
--oder 
SELECT aufgabe 
FROM Arbeit 
WHERE mit_id =(SELECT MIN(mit_id) FROM Arbeit);


-- Aufgabe 5.17
-- Nennen Sie die Ids und das Gehalt der Mitarbeiter, 
-- deren Gehalt nicht das niedrigste ist. Nutzen Sie 
-- den ANY-Operator.
--
--      mit_id  gehalt
--      2581    3000,00
--      5765    4500,00
--      9031    4000,00
--      9912    3500,00
--      10102   3500,00
--      12121   3000,00
--      ...
--      (14 Zeilen)
SELECT mit_id, gehalt
FROM Gehalt
WHERE gehalt > ANY (SELECT gehalt FROM Gehalt)
--oder 
SELECT mit_id, gehalt
FROM Gehalt
WHERE gehalt !=(SELECT MIN(gehalt) FROM Gehalt);
--oder 
SELECT DISTINCT g.mit_id, g.gehalt
FROM Gehalt g
	JOIN Gehalt g2 ON g.gehalt> g2.gehalt;

-- Aufgabe 5.18
-- Nennen Sie Id und Gehalt des Mitarbeiters mit dem
-- höchsten Gehalt. Nutzen Sie den ALL-Operator.
--
--      mit_id  gehalt
--      28559   6000,00
SELECT mit_id, gehalt
FROM Gehalt
WHERE gehalt >= ALL (SELECT gehalt FROM Gehalt)
--oder 
SELECT mit_id, gehalt
FROM Gehalt
WHERE gehalt =(SELECT MAX(gehalt) FROM Gehalt);


-- Aufgabe 5.19
-- Nennen Sie den Namen des Mitarbeiters mit der kleinsten 
-- Id. Verwenden Sie eine korrelierte Unterabfrage und den 
-- Operator NOT EXISTS.
--
--      nachname
--      Kaufmann

SELECT nachname
FROM Mitarbeiter m
WHERE NOT EXISTS (SELECT id FROM Mitarbeiter m1 
					WHERE m1.id < m.id ) ;
--oder
SELECT nachname
FROM Mitarbeiter
WHERE NOT EXISTS (SELECT id FROM Arbeit 
					WHERE id > ANY (SELECT id FROM Mitarbeiter )) ;
--oder
SELECT nachname
FROM Mitarbeiter 
WHERE id =(Select MIN(id) FROM Mitarbeiter)

--Herr Matz
SELECT m.nachname
FROM Mitarbeiter m
	LEFT JOIN Mitarbeiter m1 ON m1.id < m.id
WHERE m1.id IS NULL;
-- Aufgabe 5.20
--
-- Finden Sie die Städte, die sowohl die Wohnorte der 
-- Mitarbeiter als auch die Standorte der Abteilungen 
-- sind. Verwenden Sie eine korrelierte Unterabfrage 
-- und den Operator EXISTS.
--
--      stadt
--      München
--      Ulm
SELECT DISTINCT m.ort AS stadt 
FROM Mitarbeiter m
WHERE  EXISTS (SELECT ort FROM Abteilung ab
				WHERE ab.ort=m.ort) ;
SELECT * FROM Mitarbeiter;
--oder 
SELECT DISTINCT m.ort AS stadt 
FROM Mitarbeiter m
	join Abteilung ab ON ab.ort= m.ort;
