--	Nutzen Sie die Datenbank ProjektDB zur 
--	Lösung dieser Aufgabe


--	Aufgabe P1.3
--	Erstellen Sie eine gespeicherte Prozedur "sp_FilterMitarbeiter2",
--	die eine Liste der Mitarbeiter ausgibt, die in einer bestimmten
--	Gehalts-Range liegen. Die Prozedur soll die beiden Parameter
--	@MinGehalt und @MaxGehalt entgegennehmen. Wenn es keine passenden
--	Mitarbeiter gibt, soll eine entsprechende Meldung ausgegeben werden.
CREATE OR ALTER PROCEDURE sp_FilterMitarbeiter2
	@MinGehalt INT,
	@MaxGehalt INT 
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM Gehalt
				WHERE gehalt BETWEEN @MinGehalt AND @MaxGehalt)
		BEGIN
			SELECT m.id, m.vorname, m.nachname, m.abt_id, g.gehalt
			FROM Mitarbeiter m
				JOIN Gehalt g ON g.mit_id=m.id
			WHERE g.gehalt BETWEEN @MinGehalt AND @MaxGehalt
			ORDER BY g.gehalt DESC;
		END
	ELSE 
		SELECT 'Keine Mitarbeiter in dieser Gehalts-Range liegen' AS Fehlermeldung;
		PRINT 'Keine Mitarbeiter in dieser Gehalts-Range liegen';
END;
GO
EXEC sp_FilterMitarbeiter2
	@MinGehalt = 500, @MaxGehalt = 3000;

--	Aufgabe P1.4
--
--	Erstellen Sie eine Prozedur, die ein neues Projekt anlegt. Der
--	Prozedur sollen die Werte für die Projekt-Id, die Bezeichnung
--	und die Mittel übergeben werden. Das Projekt darf nur angelegt
--	werden, wenn es keinen Konflikt bei Id und Bezeichnung gibt.
SELECT * FROM Projekt;
GO
CREATE OR ALTER PROCEDURE pr_Projekt 
	@Pro_id INT,
	@Pro_bez NVARCHAR (30),
	@Pro_mittel money
AS 
BEGIN
	SET NOCOUNT ON;
	--IF überprüft, ob eingegebene Projekt id und Bezeichnung schon in der Projekttabelle vorhanden sind
	IF NOT EXISTS (SELECT 1 FROM Projekt
					WHERE id =@Pro_id OR @Pro_bez = bezeichnung  )
		BEGIN
			--Ausschalten der IDENTITY auf ID-Spalte in der Tabelle Projekt
			SET IDENTITY_INSERT Projekt ON;
			INSERT INTO Projekt (id,kuerzel,bezeichnung,mittel)
			VALUES (@Pro_id, UPPER(LEFT(@Pro_bez,2)),@Pro_bez,@Pro_mittel)
		END
	ELSE --wenn eingegebene ID und Bezeichnung schon vorhanden, dann wird ElSE-Bolck audgeführt.
		BEGIN
			SELECT 'Diese Projekt_id existiert breits' AS Fehlermeldung;
			PRINT 'Diese Projekt_id existiert breits';
		END
END;
GO
EXECUTE pr_Projekt
	@Pro_id = 6,
	@Pro_bez = 'Kursen',
	@Pro_mittel = 999

EXEC pr_Projekt
	@Pro_id = 12,
	@Pro_bez = 'Kursen',
	@Pro_mittel = 1000 

EXEC pr_Projekt
	@Pro_id = 9,
	@Pro_bez = 'Parken',
	@Pro_mittel = 1550

SELECT * FROM Projekt;

EXEC sp_help 'dbo.Projekt'; --alle Schlüssel der Projekttabelle anzeigen