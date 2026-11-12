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









--Eine Aufgabe und Viele Beispile für SP, UDF Formen.

--Erstelle eine Tabellenwert-Funktion mit folgenden Eigenschaften:
-- Name: GetOrdersByCustomer
-- Parameter: @CustID INT
-- Rückgabetyp: Tabellenwert-Funktion (mit Tabellenvariable).
-- Tabellenvariable: @Ergebnis
-- Spalten: OrderID INT, CustomerID INT
-- Datenquelle: Tabelle Orders
-- Bedingung: CustomerID = @CustID


--Inline-Tabellenwert-Funktionen
-- Eine Inline-Tabellenwert-Funktion gibt eine Tabelle zurück,
-- deren Daten direkt aus einer einzelnen SELECT-Abfrage stammen.
CREATE FUNCTION GetOrdersByCustomer
(	@CustID INT
)
RETURNS @ErgebniS TABLE 
(	OrderID INT,
	CustomerID INT,
)
AS
	BEGIN
		INSERT INTO @Ergebnis 
		SELECT id AS [Order ID], Cus_id AS 'Customer ID'
		FROM Orders
		WHERE Cus_id = @CustID ;
		RETURN;
	END
GO
--Aufruf
SELECT * FROM GetOrdersByCustomer(8);

--Tabellenwert-Funktionen
-- Eine Tabellenwert-Funktion mit mehreren Anweisungen erstellt
-- eine Tabellenvariable, fügt Daten ein und gibt diese Tabelle zurück.
CREATE FUNCTION GetOrdersByCustomer
(	@CustID INT
)
RETURNS TABLE
AS
RETURN(
		SELECT id AS [Order ID], Cus_id AS 'Customer ID'
		FROM Orders
		WHERE Cus_id = @CustID ;
)
GO
--Aufruf
SELECT * FROM GetOrdersByCustomer(8);

-- Weitere mit SP und UDF und erste Form der Funktionen: "Skalarwert-Funktionen"
-- Eine Skalarwert-Funktion gibt einen einzelnen Wert zurück,
-- z. B. einen INT-, VARCHAR- oder DECIMAL-Wert.
CREATE FUNCTION dbo.CalculatePrice
(
    @Price DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Result DECIMAL(10,2);

    SET @Result = @Price * 1.19;

    RETURN @Result;
END;
GO
--Aufruf
SELECT * FROM CalculatePrice(50);

--einfache Form von Stored Procedure SP
CREATE PROCEDURE dbo.GetCustomers
AS
BEGIN
    SELECT *
    FROM Customers;
END;
GO
--Aufruf
EXEC GetCustomerByID;

--SP mit Parametar 
CREATE PROCEDURE dbo.GetCustomerByID
    @CustomerID INT , @... --könnte mehrere Parameter eingegegeben werden
AS
BEGIN
    SELECT *
    FROM Customers
    WHERE CustomerID = @CustomerID;
END;
GO
--Aufruf
EXEC GetCustomerByID @CustomerID = 25;
--oder
EXEC GetCustomerByID 25;
EXEC GetCustomersByCity @City = 'Dortmund'; 



--SP Änderung der Datensätze Beispiel
CREATE PROCEDURE dbo.UpdateCustomerCity
    @CustomerID INT,
    @NewCity VARCHAR(50)
AS
BEGIN
    UPDATE Customers
    SET City = @NewCity
    WHERE CustomerID = @CustomerID;
END;
GO