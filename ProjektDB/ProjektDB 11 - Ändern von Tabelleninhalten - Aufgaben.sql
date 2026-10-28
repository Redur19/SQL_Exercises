-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:


-- =============================================
-- DDL, DML: CREATE, UPDATE, DELECT, INSERT INTO
-- =============================================
USE ProjektDB;
-- Aufgabe 11.1
-- Erstellen Sie eine neue Tabelle mit allen Abteilungen, 
-- die in München ihren Standort haben (Name: MuenchAbt), 
-- und füllen Sie diese mit den entsprechenden Reihen aus der 
-- Tabelle Abteilung. Das Attribut stadt wird in der neuen 
-- Tabelle nicht benötigt.
--
--      id  bezeichnung
--      a1  Beratung
--      a2  Diagnose
--      a4  Einkauf
BEGIN TRANSACTION;
CREATE TABLE MuenchAbt (
		id INT,
		bezeichnung VARCHAR(50)
		);
GO
INSERT INTO MuenchAbt
SELECT id, bezeichnung FROM Abteilung
WHERE ort = 'München';
COMMIT TRANSACTION;
--oder einfacher
BEGIN TRANSACTION;
SELECT id, bezeichnung 
INTO MuenchAbt
FROM Abteilung
WHERE ort = 'München';

SELECT* FROM MuenchAbt;



-- Aufgabe 11.2
-- Erstellen Sie eine Tabelle aller Sachbearbeiter (Nachname, 
-- Vorname, Abteilungsname), die im Projekt p2 arbeiten, und 
-- füllen Sie diese mit den entsprechenden Reihen aus der 
-- Tabelle Arbeit. Die Tabelle trägt den Namen: SacharbP2

--      nachname  vorname  bezeichnung
--      Keller    Hans     Freigabe
--      Mozer     Sibille  Beratung
BEGIN TRANSACTION;
CREATE TABLE SacharbP2 (
	nachname VARCHAR(30),
	vorname VARCHAR(30),
	bezeichnung VARCHAR(30)
);
GO
INSERT INTO SacharbP2
SELECT m.nachname, m.vorname, ab.bezeichnung 
FROM Mitarbeiter m 
	INNER JOIN Abteilung ab On ab.id = m.abt_id
	INNER JOIN Arbeit a ON a.mit_id = m.id AND a.pro_id = 2
WHERE a.aufgabe ='Sachbearbeiter';

COMMIT TRANSACTION;
ROLLBACK TRANSACTION;
--oder
BEGIN TRANSACTION;
SELECT m.nachname, m.vorname,
		(SELECT bezeichnung FROM Abteilung ab
		WHERE ab.id = m.abt_id) AS bezeichnung
INTO SacharbP2
FROM Arbeit a
INNER JOIN Mitarbeiter m on m.id=a.mit_id
INNER JOIN Abteilung ab ON ab.id = m.abt_id
WHERE a.pro_id = 2 AND a.aufgabe ='Sachbearbeiter';

SELECT * FROM SacharbP2;
SELECT * FROM Arbeit;
-- ======
-- UPDATE
-- ======

-- Aufgabe 11.3
-- Ändern Sie die Aufgabe des Mitarbeiters mit der Id 18316 
-- im Projekt "p2". Er soll Gruppenleiter dieses Projektes 
-- werden.
--
--      mit_id  pro_id  aufgabe        einst_dat
--      18316   p2      Gruppenleiter  2019-06-01
BEGIN TRANSACTION;
UPDATE Arbeit
SET aufgabe = 'Gruppenleiter'
WHERE pro_id = 2 AND mit_id = 18316;
COMMIT TRANSACTION;
SELECT * FROM Arbeit;

-- Aufgabe 11.4
-- Die Finanzmittel aller Projekte sollen geändert und in 
-- Schweizer Franken dargestellt werden. Der augenblickliche 
-- Währungskurs soll bei 1,04170 SFR für 1 EURO liegen.
--
--      id  bezeichnung  mittel     kunde_id
--      p1  Apollo       125004,00  3
--      p2  Gemini       98961,50   5
--      p3  Merkur       194277,05  1
--      p4  Pluto        92190,45   4
--      p5  Ariane       171880,50  2
BEGIN TRANSACTION;
UPDATE Projekt
SET mittel = mittel * 1.0417; 
COMMIT TRANSACTION;
SELECT * FROM Projekt;


-- Aufgabe 11.5
-- Die Aufgaben von Frau Huber sollen, wegen längerer Krankheit, 
-- in allen Projekten auf NULL gesetzt werden.
--
--      mit_id  pro_id  aufgabe  einst_dat
--      10102   p1      NULL     2018-10-01
--      10102   p3      NULL     2019-01-01
BEGIN TRANSACTION;
UPDATE Arbeit 
SET aufgabe = NULL 
WHERE mit_id IN ( SELECT id FROM Mitarbeiter
					WHERE nachname = 'Huber');
SELECT * FROM Arbeit
WHERE mit_id = 10102;

-- Aufgabe 11.6
-- Erhöhen Sie die Mittel in allen Projekten, abhängig von den
-- bestehenden Mitteln
--   bis 100.000 um 20 %
--   bis 150.000 um 10 %
--   ansonsten um 5 Prozent
--
--      id  bezeichnung  mittel       kd_id
--      p1  Apollo       137504,40    3
--      p2  Gemini       118753,80    5
--      p3  Merkur       203990,9025  1
--      p4  Pluto        110628,54    4
--      p5  Ariane       180474,525   2
BEGIN TRANSACTION;
UPDATE Projekt
SET mittel = CASE 
			WHEN mittel <= 100000 THEN mittel * 1.2
			WHEN mittel > 100000 AND mittel <= 150000 THEN  mittel * 1.1
			ELSE mittel * 1.05
END;
COMMIT TRANSACTION;
SELECT * FROM Projekt;

-- ======
-- Delete
-- ======

-- Aufgabe 11.7
-- Entfernen Sie alle Gruppenleiter aus den bestehenden 
-- Projekten.
BEGIN TRANSACTION;
DELETE FROM Arbeit 
WHERE aufgabe ='Gruppenleiter';
SELECT * FROM Arbeit;

-- Aufgabe 11.8
--
-- Die Mitarbeiterin namens Mozer scheidet aus der Firma 
-- aus. Versuchen Sie den Datensatz von Frau Mozer aus der 
-- Tabelle Mitarbeiter zu entfernen. Was müssen Sie tun?
BEGIN TRANSACTION;
DELETE FROM Mitarbeiter
WHERE nachname ='Mozer';--Fehlermeldung wegen Fremsschlüssel

BEGIN TRANSACTION;
UPDATE Mitarbeiter
SET  vorname = 'XXX' ,nachname = 'XXX' , abt_id = NULL , ort = NULL , chef_id = NULL
WHERE nachname ='Mozer';--Diese Lösung ist Falsch


-- Aufgabe 11.9
--
-- Löschen Sie alle Reihen der Tabelle Arbeit.
BEGIN TRANSACTION;
TRUNCATE TABLE Arbeit;

ROLLBACK TRANSACTION;

-- Aufgabe 11.10
-- Starten Sie das Skript zum Erstellen der ProjektDB
-- erneut, um den alten Zustand wiederherzustellen.
