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
	ADD
		Anrede CHAR(4),
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

SELECT * FROM Autor;

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
