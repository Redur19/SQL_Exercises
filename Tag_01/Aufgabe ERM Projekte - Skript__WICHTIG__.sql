-- master Datenbank auswählen
USE master;

-- Prüfen, ob Datenbank bereits vorhanden
IF DB_ID('Projekte') IS NOT NULL
	-- wenn ja, dann alle anderen Verbindungen kappen
	ALTER DATABASE Projekte
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- Datenbank löschen wenn da
DROP DATABASE IF EXISTS Projekte;
GO

-- Datenbank neu erstellen
CREATE DATABASE Projekte;
GO

USE Projekte;

CREATE TABLE abteilung (
	abteilungNr INT IDENTITY NOT NULL,
	bezeichnung VARCHAR(100) NOT NULL,
	standort VARCHAR(100) NOT NULL,
	CONSTRAINT pk_abteilung
		PRIMARY KEY (abteilungNr)
);

CREATE TABLE mitarbeiter (
	personalNr INT IDENTITY NOT NULL,
	name VARCHAR(50) NOT NULL,
	vorname VARCHAR(50) NOT NULL,
	gebDat DATE NOT NULL,
	gehalt MONEY NOT NULL,
	taetigkeit VARCHAR(100) NOT NULL,
	abteilungNr INT NULL,
	CONSTRAINT pk_mitarbeiter
		PRIMARY KEY (personalNr),
	CONSTRAINT fk_mitarbeiter_abteilung
		FOREIGN KEY (abteilungNr)
		REFERENCES abteilung (abteilungNr)
);

CREATE TABLE projekt (
	projektNr INT IDENTITY NOT NULL,
	bezeichnung VARCHAR(100) NOT NULL,
	beginn DATE NOT NULL,
	ende DATE NULL,
	leiterNr INT NULL,
	CONSTRAINT pk_projekt
		PRIMARY KEY (projektNr),
	CONSTRAINT fk_projekt_mitarbeiter
		FOREIGN KEY (leiterNr)
		REFERENCES mitarbeiter (personalNr)
);

CREATE TABLE projektMitarbeiter (
	projektNr INT NOT NULL,
	personalNr INT NOT NULL,
	wochenstunden FLOAT NOT NULL,
	CONSTRAINT pk_projektMitarbeiter
		PRIMARY KEY (projektNr, personalNr),
	CONSTRAINT fk_projektMitarbeiter_projekt
		FOREIGN KEY (projektNr)
		REFERENCES projekt (projektNr),
	CONSTRAINT fk_projektMitarbeiter_mitarbeiter
		FOREIGN KEY (personalNr)
		REFERENCES mitarbeiter (personalNr)
);
