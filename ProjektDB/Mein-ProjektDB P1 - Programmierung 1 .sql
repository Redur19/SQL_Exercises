--	Nutzen Sie die Datenbank ProjektDB zur 
--	Lösung dieser Aufgabe


--	Aufgabe P1.1
--	Erstellen Sie eine gespeicherte Prozedur "sp_FilterMitarbeiter1",
--	die eine Liste der Mitarbeiter ausgibt, die in einer bestimmten
--	Abteilung arbeiten. Die Prozedur soll den Parameter @Abteilung
--	für die Bezeichnung der Abteilung entgegennehmen.
--
--	Beispiel: EXEC sp_FilterMitarbeiter1 'Einkauf'
--	
--	id     vorname  nachname  abt_id  bezeichnung
--	-----  -------  --------  ------  -----------
--	9912   Klaus    Wolf      a4      Einkauf
--	12121  Ursula   Richter   a4      Einkauf
--	20204  Dirk     Fuchs     a4      Einkauf
--	22222  Anke     Vogel     a4      Einkauf

CREATE OR ALTER PROCEDURE dbo.Einkauf
    @abt_id INT
AS
BEGIN
    SELECT m.id, m.vorname, m.nachname, m.abt_id, ab.bezeichnung 
    FROM Mitarbeiter m
        JOIN Abteilung ab ON ab.id= m.abt_id
    WHERE m.abt_id = @abt_id;
END;
GO

EXEC dbo.Einkauf 
    @abt_id = 8;

--Herr Matz
GO
CREATE PROCEDURE sp_FilterMitarbeiter1
    @Abteilung VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;--Optional Status-Meldungen werden unterdrückt (z.B 3 Zeilen betroffen),
                    -- bei großen DB bessere Performance

    -- Prüfen, ob es Mitarbeiter in der angegebenen Abteilung gibt
    IF EXISTS (
        -- SELECT 1: Spalten werden hier dargestellt, Performancevorteile, TRUE AND FALSE wird
        -- ausgewertet
        SELECT 1
        FROM Mitarbeiter m
        JOIN Abteilung a ON m.abt_id = a.id
        WHERE a.bezeichnung = @Abteilung
    )
    BEGIN
        SELECT 
            m.id AS [id], m.vorname, m.nachname, m.abt_id, a.bezeichnung
        FROM Mitarbeiter m
            JOIN Abteilung a ON m.abt_id = a.id
        WHERE a.bezeichnung = @Abteilung
        ORDER BY m.id;
    END
    ELSE
    BEGIN
        PRINT 'Keine Mitarbeiter in der angegebenen Abteilung gefunden.';
    END
END;
GO

EXEC sp_FilterMitarbeiter1 'Einkauf';


--	Aufgabe P1.2
--	Verändern Sie die Prozedur aus Aufgabe P.1.
--	Wenn keine Mitarbeiter zur angeforderten Abteilung gefunden
--	werden, soll der Text 'Abteilung ungültig: <Bezeichnung>'
--	angezeigt werden. Entweder im Meldungs-Fenster oder im Grid.
--
--	Beispiel: EXEC sp_FilterMitarbeiter1 'Produktion'
--
--	Fehlermeldung
--	------------------------------
--	Abteilung ungültig: Produktion
GO
CREATE OR ALTER PROCEDURE sp_FilterMitarbeiter1 -- muss nicht Schemaname schreiben also bei mir ist dbo 
    @abt_bez VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON; --zeigt keine Meldungen über die Anzahl der betroffenen Zeilen an.
    IF NOT EXISTS (SELECT bezeichnung FROM Abteilung --wenn () kein Ergibnis gibt dann BEGIN wird ausgeführt  
                    WHERE bezeichnung = @abt_bez)
        BEGIN 
            PRINT ('Abteilung ungültig ' +'<'+ @abt_bez+'>');
            SELECT  'Abteilung ungültig: ' + @abt_bez AS Feglermeldung;
        END;
     ELSE
        SELECT m.id, m.vorname, m.nachname, m.abt_id, ab.bezeichnung 
        FROM Mitarbeiter m
            JOIN Abteilung ab ON ab.id= m.abt_id
        WHERE ab.bezeichnung = @abt_bez;
END;
GO

EXEC sp_FilterMitarbeiter1
    @abt_bez = 'Produktion';
-- Olivers Lösung
GO
CREATE OR ALTER PROCEDURE sp_FilterMitarbeiter1
    @abt_bez VARCHAR(50)
AS
BEGIN
    IF @abt_bez IN (SELECT bezeichnung FROM Abteilung
                    WHERE @abt_bez = bezeichnung)
                    
            SELECT m.id, m.vorname, m.nachname, m.abt_id, ab.bezeichnung 
            FROM Mitarbeiter m
                JOIN Abteilung ab ON ab.id= m.abt_id
            WHERE @abt_bez = bezeichnung;

    ELSE
        PRINT 'Abteilung ungültig '
END;
GO

EXEC sp_FilterMitarbeiter1
    @abt_bez = 'Produktion';

DROP PROCEDURE IF EXISTS sp_FilterMitarbeiter1;
DROP PROCEDURE IF EXISTS dbo.Einkauf;
