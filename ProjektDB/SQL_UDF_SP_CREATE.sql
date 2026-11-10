CREATE OR ALTER PROCEDURE sp_GetKundenNachOrt
    @SuchOrt VARCHAR(50) -- Ein optionaler Parameter, den man beim Aufruf übergeben kann
AS
BEGIN
    -- Hier beginnt der ausführbare Block
    
    SELECT id, firma, ort
    FROM Kunde
    WHERE ort = @SuchOrt;

END; -- Hier endet der Block
GO


-- Was eignet sich besser SP oder UDF
-- eine udf für Abfragen und Anzeigen von Daten

CREATE OR ALTER FUNCTION dbo.fn_GetKundenNachOrt 
(
    @SuchOrt VARCHAR(50)
)
RETURNS TABLE
AS
RETURN 
(
    SELECT id, firma, ort
    FROM Kunde
    WHERE ort = @SuchOrt
);
GO