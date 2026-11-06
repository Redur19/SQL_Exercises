
--1. Schritt sich beim Datenbankserver anmelden und eunen Login erstellen
CREATE LOGIN red WITH PASSWORD = 'Pa$$w0rd'; 

-- 2. Datenbank auswählen
USE ProjektDB; 

-- 3. User für den Login in ProjektDB erstellen (Verbindung zum SQL- SERVER)
CREATE USER red For LOGIN red;

-- 4. Leserecht auf die Tabelle geben ,mit GRANT
GRANT SELECT		--Zuwiesung der Rechte (DENY, REVOKE); Lesen: SELECT Schreiben
					--INSERT, UPDATE, DELETE
ON dbo.Mitarbeiter	--ON-KAUSEL, Bezeichnung des Objekts auf das sich die Recht beziehen 
					--hier dbo (database owner) Tabelle Mitarbeiter, SCHEMA:: dbo
To red;

REVOKE SELECT  --löscht die Rechte 
ON dbo.Mitarbeiter
TO red;

DENY SELECT		
ON dbo.Mitarbeiter 					
TO red;
--GRANT	Erlauben 
--DENY	Verbieten 
--REVOKE	Aufhebung einer Berechtigung

--mehrere Rechte gleichzeitig zuteilen zum Lesen und Schreiben für alle DBs
GRANT SELECT , INSERT, UPDATE, DELETE
ON SCHEMA::dbo
To red;

-- Zeigt die Berechtigungen des Benutzers „red“ an.
SELECT *
FROM sys.database_permissions
WHERE grantee_principal_id = USER_ID('red');

-- Führt die folgenden Befehle mit den Rechten von „red“ aus.
EXECUTE AS USER = 'red';

-- Beendet den Benutzerkontext von „red“ und kehrt zum ursprünglichen Benutzer zurück.
REVERT;

-- Zeigt die Berechtigung, den Status und den Geltungsbereich von „red“ an.
SELECT
    permission_name,
    state_desc,
    class_desc
FROM sys.database_permissions
WHERE grantee_principal_id = USER_ID('red');
