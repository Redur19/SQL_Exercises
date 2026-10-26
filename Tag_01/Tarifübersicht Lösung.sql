USE master;

IF DB_ID('TarifUebersicht') IS NOT NULL
	ALTER DATABASE TarifUebersicht
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

DROP DATABASE IF EXISTS TarifUebersicht;
GO

CREATE DATABASE TarifUebersicht;
GO

USE TarifUebersicht;

CREATE TABLE Ansprechpartner (
	AnsprechpartnerNr INT IDENTITY,
	Vorname VARCHAR(50) NOT NULL,
	Nachname VARCHAR(50) NOT NULL,
	Telefon VARCHAR(30) NULL,
	Email VARCHAR(75) NULL,
	CONSTRAINT PK_Ansprechpartner
		PRIMARY KEY (AnsprechpartnerNr)
);

CREATE TABLE Tarif (
	TarifNr INT IDENTITY,
	Bezeichnung VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Tarif
		PRIMARY KEY (TarifNr)
);

CREATE TABLE Kunde (
	KundenNr INT IDENTITY,
	Vorname VARCHAR(50) NOT NULL,
	Nachname VARCHAR(50) NOT NULL,
	Strasse VARCHAR(50) NOT NULL,
	PLZ CHAR(5) NOT NULL,
	Ort VARCHAR(50) NOT NULL,
	AnsprechpartnerNr INT NULL,
	CONSTRAINT PK_Kunde
		PRIMARY KEY (KundenNr),
	CONSTRAINT FK_Kunde_Ansprechpartner
		FOREIGN KEY (AnsprechpartnerNr)
		REFERENCES Ansprechpartner (AnsprechpartnerNr)
);

CREATE TABLE KundeTarif (
	KundeTarifNr INT IDENTITY,
	KundenNr INT NOT NULL,
	TarifNr INT NOT NULL,
	Startdatum DATE NOT NULL,
	Enddatum DATE NULL,
	CONSTRAINT PK_KundeTarif
		PRIMARY KEY (KundeTarifNr),
	CONSTRAINT FK_KundeTarif_Kunde
		FOREIGN KEY (KundenNr)
		REFERENCES Kunde (KundenNr),
	CONSTRAINT FK_KundeTarif_Tarif
		FOREIGN KEY (TarifNr)
		REFERENCES Tarif (TarifNr)
);

SELECT * FROM Kunde;
