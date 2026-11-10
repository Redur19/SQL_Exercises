--Batch
--Variablen Deklaration
DECLARE @zahl1 int = 11, @zahl2 int = 22;
DECLARE @ergebnis int ;

--Wertzuweisung 
SET @ergebnis = @zahl1 + @zahl2;

--Ausgabe im Medlungsfenster
PRINT @ergebnis;

--Ausgabe im Ergebnisfenster
SELECT @ergebnis;

--Kombinierte Ausgabe
PRINT 'Das Ergbnis Lautet: ' + CAST(@ergebnis AS VARCHAR(10)) ;
--END Batch
GO
--GO beendet einen Batch

--IF / ELSE

--Deklaration und Initialisierung
DECLARE @zahl TINYINT = 42;
--Die IF / ELSE Anweisung
IF @zahl = 42						--Wenn Prüfung TRUE ergibt
	BEGIN							--Beginn des TRUE-Blocks			
		PRINT '@zahl = 42' ;
	END								--Ende des TRUE-Blocks
IF @zahl < 45						
	BEGIN										
		PRINT '@zahl  < 45' ;
	END							
ELSE								--Wenn Prüfung FALSE ergibt
	BEGIN							--Beginn des FALSE-Blocks
		PRINT '@zahl <> 42' ;		
	END								--Ende des FALSE-Blocks
--Nach der IF/ELSE-Aneidung geht es normal witer
PRINT 'Das ist das Ende:';
GO




--verschachteltes IF/ELSE 
--Variablen Deklaration
DECLARE @kundenTyp VARCHAR(20) = 'Premium';
DECLARE @Bestellwert DECIMAL(10,2) = 150.00;
DECLARE @Rabatt DECIMAL(5,2);

--Äussere Verzweigung: Prüfung des Kundentyps
IF @kundenTyp = 'Premium'
	BEGIN
	PRINT 'Kunde isst Premium-Mitgelied';
	--Innere Verzweisung (Verschachtelung 1): Bestellwert bei Premium prüfen
	IF @Bestellwert >= 200.00
		BEGIN	
			SET @Rabatt =0.20; --20 % Rabatt
		END
	ELSE 
		BEGIN	
			SET @Rabatt =0.10; --10 % Rabatt
		END
	END
ELSE
	BEGIN	
		PRINT 'Kunde ist Standart-Mitgelied' ;
	--Innere Verzweisung (Verschachtelung 2): Bestellwert bei Standart prüfen
		IF @Bestellwert >= 100.00
		BEGIN	
			SET @Rabatt =0.05; --5 % Rabatt
		END
	ELSE 
		BEGIN	
			SET @Rabatt =0.00; --kein Rabatt
		END
	END
--Audgabe des finalen Ergebnisses
PRINT 'DER gewährte Rabatt beträgt: ' + CAST(@Rabatt AS VARCHAR(5)) + '%'; 
GO


--CASE 

-- Deklaration der Variablen
DECLARE @zahl INT = 42;
DECLARE @text VARCHAR(30);

-- Text für Ausgabe auswählen
SET @text = CASE 
    WHEN @zahl = 42 THEN 'Treffer!'
    WHEN @zahl = 41 THEN 'Ein kleines bisschen zu wenig.'
    WHEN @zahl = 43 THEN 'Ein kleines bisschen zu viel.'
    ELSE 'Voll daneben!'
END;
-- Ausgabe
PRINT @text
GO

--oder 
DECLARE @zahl INT = 43;
DECLARE @text VARCHAR(30);

-- Text für Ausgabe auswählen
SET @text = CASE @zahl 
    WHEN 42 THEN 'Treffer!'
    WHEN 41 THEN 'Ein kleines bisschen zu wenig.'
    WHEN 43 THEN 'Ein kleines bisschen zu viel.'
    ELSE 'Voll daneben!'
END;
-- Ausgabe
PRINT @text
GO



-- komplexes CASE
-- Deklaration der Variablen
DECLARE @zahl INT = 40;
DECLARE @text VARCHAR(30);
--Text für Ausgabe auswäheln
SET @text = CASE
WHEN @zahl = 42 THEN 'Treffer!'
WHEN ABS(42 -@zahl) <= 2 THEN 'Nah dran ...'
WHEN @zahl % 2 = 0 THEN 'Immerhin gerade ...'
ELSE 'Voll daneben!'
END;
--Ausgabe
PRINT @text
GO



-- WHILE-Schleife
DECLARE @zahl TINYINT = 40;
WHILE @zahl < 42
BEGIN
    PRINT 'Wir sind aktuell bei ' + CAST(@zahl AS char(2));
    SET @zahl = @zahl + 1;
END
-- Ausgabe am Ende
IF @zahl = 42

	PRINT 'Wir haben es geschafft: ' + CAST(@zahl AS char(2));
ELSE
	PRINT 'Wir wollten zu hoch hinaus ...';
GO


-- While-Schleife mit Break und Continue
DECLARE @zaehler INT = 0;

WHILE @zaehler < 10
BEGIN
	SET @zaehler = @zaehler + 1;
	
	-- 1. Beispiel für  Continue:
	-- Überspringe alle Zahlen, die glatt durch 3 teilbar sind.
	IF @zaehler % 3 = 0
	BEGIN
		PRINT '--- Übersringe Vielfaches von 3: ' + CAST(@zaehler AS VARCHAR(2)) + ' ---';
		CONTINUE; -- Bricht diesen Durchlauf sofort ab und springt zum Schleifenkopf zurück
	END

	-- 2. Beispiel Für BREAK:
	-- Die Schleife soll sofort komplett abgebrochen werden, wenn der Zähler 8 erreicht:
	IF @zaehler = 8
	BEGIN
		PRINT '--- Abruchbedingung erreicht! Stopp bei Wert: ' + CAST(@zaehler AS VARCHAR(2)) + ' ---';
		BREAK; -- Verlässt die WHILE-Schleife sofort komplett.
	END
	-- Reguläre Ausgabe für alle anderen Zahlen
	PRINT 'Verarbeite Zählerstand: ' + CAST(@zaehler AS VARCHAR(2));
END
PRINT 'Schleife wurde vollständig beendet.';
GO




--TRY / CATCH
-- Deklaration
DECLARE @zahl1 TINYINT = 10;
DECLARE @zahl2 TINYINT = 0;

-- Ausführung ohne TRY/CATCH
PRINT 'Addition:';
SELECT @zahl1 + @zahl2;
PRINT 'Subtraktion:';
SELECT @zahl1 - @zahl2;
PRINT 'Division:';
SELECT @zahl1 / @zahl2; 
PRINT 'Multiplikation:';
SELECT @zahl1 * @zahl2;
-- Ende
PRINT 'Fertig!';
GO

-- Deklaration
DECLARE @zahl11 TINYINT = 10;
DECLARE @zahl22 TINYINT = 0;

-- Ausführung mit TRY/CATCH
BEGIN TRY
    PRINT 'Addition:';
    SELECT @zahl11 + @zahl22;
    PRINT 'Subtraktion:';
    SELECT @zahl11 - @zahl22;
    PRINT 'Division:';
    SELECT @zahl11 / @zahl22;
    PRINT 'Multiplikation:';
    SELECT @zahl11 * @zahl22;
END TRY
BEGIN CATCH
    PRINT 'Im CATCH-Block';
END CATCH

PRINT 'Fertig!';
-- WHEN ... THEN kann sich beliebig oft wiederholen
-- Der ELSE-Zweig ist optional
GO



--Zu den aufgetretenen Fehlern können eine Reihe von Infos abgefragt werden
BEGIN TRY
    -- Ein "divide by zero"-Error
    -- wird provoziert:
    SELECT 1/0;
END TRY
BEGIN CATCH
    -- Ausgabe der relevanten
    -- Informationen als Tabelle
    SELECT
        ERROR_NUMBER() AS errNum,
        ERROR_SEVERITY() AS errSev,
        ERROR_STATE() AS errState,
        ERROR_PROCEDURE() AS errProc,
        ERROR_LINE() AS errLine,
        ERROR_MESSAGE() AS errMess
END CATCH
GO

