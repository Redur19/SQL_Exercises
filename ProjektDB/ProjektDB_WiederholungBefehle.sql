USE ProjektDB;

SELECT * FROM Kunde;
-- DML (Data Manipulation Language), Kommandos: INSERT, UPDATE, DELETE
BEGIN TRANSACTION;
INSERT INTO Kunde
	VAlUES ('Max Mustermann', 'Hamburg');
ROLLBACK TRANSACTION;
-- INSERT fügt einen neuen Datensatz hinzu, die id muss nicht angegeben werden,
-- da für id die Option IDENTITY gesetzt ist. Hier wird die id automatisch vergeben, 
-- beginnend mit der nächst möglichen id, in einser Schritten aufwärts

-- Löschen der Datensätze, die einen Fremdschlüssel in einer anderen Tabelle haben
-- ist nicht möglich.
BEGIN TRANSACTION;
DELETE FROM Kunde
WHERE id = 1;


--Diese Anweisung führt zu einem Fehler "Konflikt mit der REFERENCE-Einschränkung
--fk_projekt_kunde". Für doesem Datensatz in der Elternatabelle (Kunde) steht ein 
--Fremdschlüssel in der Kindtabelle (Projekt). Wenn der Datensatz glöscht würde,
--wäre der Fremdschlüssel in der Projekttabelle ungältig. Das ist verboten. Das Prinzip
-- nennt sich Referentielle Integrität.
-- Nur Datensätze die keine Referenz in einer anderen Tabelle haben, können gelöscht werden
DELETE FROM Kunde 
WHERE id = 7;

CREATE TABLE Ueb_Trunc (
	id INT IDENTITY,
	Bezeichnung VARCHAR(20));

INSERT INTO Ueb_Trunc 
VALUES ('Test'),('einfach für Trunc');

SELECT * FROM Ueb_Trunc;

--Wenn ich mit DELETE die Datensätze einer Tabelle lösche und IDENTITY für 
--die id-Spalte definiert ist, dann wird der Zähler nicht zurückgesetzt,
--sondern zählt beim letzten Wert weiter. Beim Einfügen eines neuen
--Datensatzes wird die ID mit dem nächsten Wert des Zählers vergeben.
BEGIN TRANSACTION;
DELETE FROM Ueb_Trunc;

ROLLBACK TRANSACTION;

--Wenn ich mit TRUNCATE die Datensätze einer Tabelle lösche und IDENTITY für 
--die id-Spalte definiert ist, dann wird der Zähler auf 1 zurückgesetzt. Beim Einfügen
--eines neuen Datensatz beginnt dieser automatisch mit der id 1.
BEGIN TRANSACTION;
TRUNCATE TABLE Ueb_Trunc;

ROLLBACK TRANSACTION;

--Mit DROP löschen wir die Tabelle also nicht die Datensätze.
BEGIN TRANSACTION;
DROP TABLE Ueb_Trunc;

COMMIT TRANSACTION;
ROLLBACK TRANSACTION;

-- Unterabfragen beim Ändern von Tabellenwerten mit Filterkriterien aus einer anderen
-- Tabelle
BEGIN TRANSACTION;
UPDATE Kunde
SET ort = 'Hamburg'
WHERE id IN (
			SELECT kunde_id FROM Projekt
			WHERE mittel < 100000);
ROLLBACK TRANSACTION;
SELECT * FROM Kunde;

--Erstellen eine Backup-Tabelle der Arbeit-Tabelle.
CREATE TABLE BackupArbeit (
			mit_id INT,
			pro_id CHAR (2),
			aufgabe VARCHAR(30),
			einst_dat DATE);
--Verifizieren ob die neu angelegte Tabelle vorhanden ist
SELECT * FROM BackupArbeit;

--fügte den kompletten Datensätze von Arbeit in BackupArbeit ein
INSERT INTO BackupArbeit
SELECT * FROM Arbeit;

--Lösche des kompletten Inhalts von Arbeit
DELETE FROM Arbeit;

--Datensätze aus der Backup-Tabelle in die Tabelle Arbeit einfügen
INSERT INTO Arbeit
SELECT * FROM BackupArbeit;

--Löschen der Backup-Tabelle
DROP TABLE BackupArbeit;