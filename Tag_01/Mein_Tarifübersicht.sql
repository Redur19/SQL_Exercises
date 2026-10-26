USE master;

IF DB_ID('TarifUebersicht') IS NOT NULL
	ALTER DATABASE TarifUebersicht
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

DROP DATABASE IF EXISTS TarifUebersicht;
GO

CREATE DATABASE TarifUebersicht;

USE TarifUebersicht;

CREATE TABLE Ansprechpartner (
	AnsprechpartnerNR INT IDENTITY,
	Vorname VARCHAR (50) NOT NULL,
	Nachname VARCHAR (50) NOT NULL,
	Telefon VARCHAR (30) NULL,
	Email VARCHAR(75) NULL,
	CONSTRAINT pk_Ansprechpartner 
		PRIMARY KEY (AnsprechpartnerNR),
);
CREATE TABLE Kunde (
	KundeNR INT IDENTITY CONSTRAINT pk_Kunde PRIMARY KEY,
	Vorname VARCHAR (50) NOT NULL,
	Nachname VARCHAR (50) NOT NULL,
	Strasse VARCHAR (50) NULL,
	PLZ CHAR (6) NULL,
	Ort VARCHAR (50) NOT NULL,
	AnsprechpartnerNR INT, 
	CONSTRAINT AnsprechpartnerNR
		FOREIGN KEY (AnsprechpartnerNR)
		REFERENCES Ansprechpartner (AnsprechpartnerNR)
);
CREATE TABLE Tarif (
	TarifNR INT IDENTITY CONSTRAINT pk_TarifNR PRIMARY KEY,
	Bezeichnung VARCHAR (50) NOT NULL,
);
CREATE TABLE Kunde_Tarif (
	KundeTarifNR INT IDENTITY CONSTRAINT pk_KundeTarifNR PRIMARY KEY,
	Kunde_NR INT,
	Tarif_NR INT,
	Startdatum DATE NOT NULL,
	Enddatum DATE NOT NULL,
	CONSTRAINT fk_KundeTarif_Kunde
		FOREIGN KEY (Kunde_NR)
		REFERENCES Kunde (KundeNR),
	CONSTRAINT fk_KundeTarif_Tarif
		FOREIGN KEY (Tarif_NR)
		REFERENCES Tarif (TarifNR),
);
