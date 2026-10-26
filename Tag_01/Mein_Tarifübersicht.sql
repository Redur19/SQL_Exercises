--Darenbank erstellen
CREATE DATABASE testdb;

-- Datenbank auswählen
USE testdb;

-- Tabelle erstellen
CREATE TABLE testTable(
	id INT,
	vorname VARCHAR (50),
	nachname VARCHAR(50),
	geburt DATE
);

-- PRIMARY KEY ist automatische immer not Null.
-- IDENTITY gibt automatisch noch nicht gegebende ID.
-- IDENTITY Automatische Nummerierung: Start bei 10000, danach immer +10
-- NOT NULL Darf nicht leer sein
CREATE TABLE testTable2 (
	id INT IDENTITY(10000,10) PRIMARY KEY,
	vorname VARCHAR(50) NOT NULL,
	nachname VARCHAR(50) NOT NULL,
	geburt DATE NULL
);

--Zwei Tabellen mit Beziehungen
-- CONSTRAINT beninnt den Schlüssel.
CREATE TABLE author(
	id INT IDENTITY CONSTRAINT pk_author PRIMARY KEY,
	firstname VARCHAR(50) NOT NULL,
	lastname VARCHAR(50) NOT NULL,
);

CREATE TABLE book(
	isbn CHAR (13) CONSTRAINT pk_book PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	price MONEY NULL,
);

CREATE TABLE authorbook(
	author_id INT,
	isbn CHAR (13), 
	CONSTRAINT pk_authorbook 
		PRIMARY KEY (author_id, isbn),
	CONSTRAINT fk_authorbook_author 
		FOREIGN KEY (author_id)
		REFERENCES author (id),
	CONSTRAINT fk_authorbook_book 
		FOREIGN KEY (isbn)
		REFERENCES book (isbn)
);

DROP TABLE testTable2;


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
