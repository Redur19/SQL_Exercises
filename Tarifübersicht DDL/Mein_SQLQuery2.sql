
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



USE TarifUebersicht;

INSERT INTO Ansprechpartner
VALUES ('Hans','Müller','0111-45678','hans.mueller@energieversorger.de');

SELECT * FROM Ansprechpartner;

INSERT INTO Kunde 
VALUES (1234, 'Clara','Maier','Waldessaum 11','99999','Tannen', 1);
SELECT * FROM Kunde;

INSERT INTO Tarif
VALUES ('Ökostrom normal'),
		('Ökostrom 3+');

SELECT * FROM Tarif;

INSERT INTO Kunde_Tarif 
VALUES (1234 , 1,'20210101','20210403'),
		(1234, 2 , '20210404','20211031'),
		(1234 , 1 , '20211101','20211231');
SELECT * FROM Kunde_Tarif;
--c)
CREATE TABLE Kundengruppe (
	KundengruppeNr INT IDENTITY NOT NULL,
	Name VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Kundengruppe
		PRIMARY KEY (KundengruppeNr)
);

SELECT * FROM Kundengruppe;
--d)
INSERT INTO Kundengruppe
VALUES ('Stammkunden') ,('Rabatt-Jäger');

--e)
ALTER TABLE kunde
ADD KundengruppeNr INT NULL;

ALTER TABLE kunde
ADD CONSTRAINT fk_kunde_gruppe
FOREIGN KEY (KundengruppeNr)
REFERENCES Kundengruppe (KundengruppeNr);

--f)
UPDATE Kunde
SET KundengruppeNr = 1;
--WHERE brauchen wir nicht weil die Aufgabe sagt alle Kunde.

--g) 
SELECT * FROM Kunde
WHERE KundengruppeNr IS NULL; -- Damit sichergestellt ist, dass alle Kunden eine Gruppennummer haben, da NULL keine leeren Werte zulässt.
ALTER TABLE kunde
ALTER COLUMN KundengruppeNr INT NOT NULL;

SELECT * FROM Kunde
WHERE KundengruppeNr IS NULL;

--h) 
EXEC sp_rename 'Kundengruppe.Name','Bezeichnung','COLUMN';

i)
ALTER TABLE Kunde
DROP CONSTRAINT fk_kunde_gruppe;

ALTER TABLE Kunde
DROP COLUMN KundengruppeNr;

DROP TABLE Kundengruppe;

SELECT * FROM Kunde;