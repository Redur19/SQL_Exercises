USE BuchclubDB;
GO
--Anzeigen von Nachname des Autors und dem Buch des Autors
SELECT * FROM Autor;
SELECT a.nachname, b.titel FROM Buch b
	INNER JOIN AutorBuch ab ON ab.buch_id=b.id
	INNER JOIN Autor a ON a.id=ab.autor_id;

--Ergänzen von Spalten zur Tabelle Autor , Spalte Anrese und Spalte Email. 
BEGIN TRANSACTION;
--Startet eine Transaktion, die rückgängig gemacht werden kann
ALTER TABLE Autor
	ADD	Anrede CHAR(4),
		Email VARCHAR(40);



--ROLLBACK macht die Änderungen der Transaktion rückgängig.
ROLLBACK TRANSACTION;
--COMMIT Bestätigt und speichert die Änderungen dauerhaft in der Datenbank.
COMMIT TRANSACTION;



--Erstellen einer CHECK-Regel, die prüft ob bei der Erstellung eines neuen Datensatzes
--nur Frau oder Herr eingegeben wurde.
ALTER TABLE Autor 
ADD CONSTRAINT ck_autor_anrede
	CHECK (Anrede IN('Frau','Herr'));

--Aufgabe: Prüfen ob die Checkregel funktioniert
--Zwei Möglichkeiten:	1. Einen neuen Datensatz mit INSERT anlegen
--						2. Einen bestehenden Datensatz in der Spalte Anrede ändern
--Zu 1
BEGIN TRANSACTION;
INSERT INTO Autor
VALUES (4,'Serede','Redur','19950101','Prof',NULL);--Fehlermeldung

INSERT INTO Autor
VALUES (4,'Serede','Redur','19950101','Herr',NULL);

--Zu 2
BEGIN TRANSACTION;
UPDATE Autor
SET Anrede ='Prof'
WHERE id = 1;
--führt zu der Fehlermeldung, das eine ungültige Zeichenfolge verwendet wurde.
--'Prof' steht in Konflikt mit der Check-Regel.

BEGIN TRANSACTION;
UPDATE Autor
SET Anrede ='Prof'
WHERE id = 1;--Fehlermeldung weil es mehr als 4 Buchstaben 

BEGIN TRANSACTION;
UPDATE Autor
SET Anrede ='Herr'
WHERE id = 1;
--führt zu der Fehlermeldung, das eine ungültige Zeichenfolge verwendet wurde.
--Es wurden 5 Zeichen eingegeben und in der Spalte Anrede ist als Datentyp char(4) hinter
BEGIN TRANSACTION;
ALTER TABLE Autor
ADD CONSTRAINT ck_autor_email
	CHECK ( Email LIKE '%_@_%_._%' AND Email NOT LIKE '%@%@%'); --lässt @ sich nicht wiederholen.
	--oder CHECK(Email LIKE '%@%.%')

BEGIN TRANSACTION;
UPDATE Autor
SET Email ='red@ma@il.com'
WHERE id = 4;--Fehlermeldung

BEGIN TRANSACTION;
UPDATE Autor
SET Email ='redmail.com'
WHERE id = 4;--Fehlermeldung

BEGIN TRANSACTION;
UPDATE Autor
SET Email ='red@mail.com'
WHERE id = 1;--Ohne Fehler

ROLLBACK TRANSACTION;
COMMIT TRANSACTION;

select * from Autor;
-- 10. Stunde Verändern Sie die Spalte Email so, dass Sie nur einmalige Werte erlauben
-- Nutzen Sie die Spaltenoption UNIQUE. Überlegen Sie wie die Spalte ändern müssen, damit
-- der Zustand der Spalte mit der Option UNIQUE übereinstimmt.
-- 1.Schritt Einfügen von einzigartigen Emails in der Emailspalte.
BEGIN TRANSACTION
UPDATE Autor
	SET Email = 'mueller@email.com'
	WHERE id = 2;
UPDATE Autor
	SET Email = 'walter@email.com'
	WHERE id = 3;
UPDATE Autor
	SET Email = 'meier@email.com'
	WHERE id = 4;

ROLLBACK TRANSACTION;

-- Alternative zum Einfügen über mehrere UPDATE Anweisungen, mit einer CASE-Anweisung
BEGIN TRANSACTION;
UPDATE Autor
SET Email = CASE
	when id = 1 THEN 'schmitt@email.com'
	WHEN id = 2 THEN 'mueller@email.com'
	WHEN id = 3 THEN 'walter@email.com'
	WHEN id = 4 THEN 'sereda@email.com'
	ELSE Email -- Der Rest bleibt unverändert
END;
-- Optional:
--WHERE Anrede = 'Herr' -- hier wird nur die Email der männlichen Autoren gesetzt.
COMMIT TRANSACTION;

-- 2.Schritt: Die Spalte Email auf NOT NULL umstellen
ALTER TABLE Autor
ALTER COLUMN Email VARCHAR(40) NOT NULL;

-- 3. Schritt UNIQUE-CONSTRAINT (die Einzigartigkeit) als Regel hinzufügen

ALTER TABLE Autor
ADD CONSTRAINT uq_autor_email UNIQUE(email);

-- Bei einer bestehenden DB sind Änderungen auf Tabellenebene
-- mit CONSTRAINTS das bessere Mittel, weil sie realtiv einfach über DROP CONSTRAINT
-- entfernt werden können.
INSERT INTO Autor (id, vorname, nachname, Anrede, Email)
	VALUES (6, 'Anna', 'Speer', 'Frau', 'walter@email.com');--Fehlermeldung Weil diese email schon vorhanden ist.
INSERT INTO Autor (id, vorname, nachname, Anrede, Email)
	VALUES (6, 'Anna', 'Speer', 'Frau', NULL);--Fehlermeldung Email ist NOT NULL.
Select * From Autor;

-- DELETE löscht den Datensatz mit der id 5.
DELETE FROM Autor
WHERE id = 5;

ROLLBACK TRANSACTION;
-- Alternative? Dies funktioniert nicht da sich
-- UNIQUE nur in einer CONSTRAINT einsetzen lässt.
BEGIN TRANSACTION;
ALTER TABLE Autor
ALTER COLUMN Email VARCHAR(40) NOT NULL UNIQUE

-- CONSTRAINT löschen, hier UNIQUE
ALTER TABLE Autor
DROP CONSTRAINT uq_autor_email;

-- Finden der gesetzten CONSTRAINTS in der Tabelle Autor
SELECT
	CONSTRAINT_NAME,
	CONSTRAINT_TYPE,
	TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Autor';

-- Die Constraints stehen in den Metadaten der Benutzerdatenbank (hier BuchclubDB).
-- Dies bezieht sich auch auf die Store Procedures in Ihrer Benutzerdatenbank.
-- Stored Procedures sind Funktionen, die fest in Ihrer Datenbank hinterlegt sind oder
-- die sie selber geschrieben haben.
-- Metadaten stehen hier in INFORMATION_SCHEMA
--Anzeige der CONSTRAINT über eine Stored Procedure
EXEC sp_helpconstraint 'Autor';