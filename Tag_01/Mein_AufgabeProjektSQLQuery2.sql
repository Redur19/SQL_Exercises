CREATE DATABASE Aufgabe_Projekte;
GO

USE Aufgabe_Projekte;

CREATE TABLE Abteilung(
	AbteilungNr INT IDENTITY,
	Bezeichnung VARCHAR (50) NOT NULL,
	Standort VARCHAR (50) NOT NULL,
	CONSTRAINT Pk_Abteilung
		PRIMARY KEY (AbteilungNr)
);
CREATE TABLE Mitarbeiter (
	PersonalNr INT IDENTITY,
	Vorname VARCHAR (50) NOT NULL,
	Nachname VARCHAR (50) NOT NULL,
	geburtsdatum DATE NOT NULL,
	Gehalt INT NOT NULL,
	Tatigkeit VARCHAR (50) NOT NULL,
	AbteilungNr INT,
	CONSTRAINT Pk_Mitarbeiter
		PRIMARY KEY (PersonalNr),
	CONSTRAINT Fk_AbteilungNr
		FOREIGN KEY (AbteilungNr)
		REFERENCES Abteilung (AbteilungNr),

);

-- ALTER TABLE Mitarbeiter DROP CONSTRAINT Fk_AbteilungNr
ALTER TABLE Mitarbeiter ADD
		CONSTRAINT Fk_AbteilungNr
			FOREIGN KEY (AbteilungNr)
			REFERENCES Abteilung (AbteilungNr)

CREATE TABLE Projekt (
	ProjektNr INT IDENTITY,
	Bezeichnung VARCHAR (50) NOT NULL,
	Projektbeginn DATE NOT NULL,
	Projektende DATE NOT NULL,
	Leiter INT ,
	CONSTRAINT Pk_Projekt
		PRIMARY KEY (ProjektNr),
	CONSTRAINT Fk_Leitermitarbeiter
		FOREIGN KEY (Leiter)
		REFERENCES Mitarbeiter (PersonalNr)

);
CREATE TABLE MitarbeiterProjekt (
	PersonalNr INT ,
	ProjektNr INT,
	StundenZahl FLOAT NOT NULL,
	CONSTRAINT Pk_MitarbeiterProjekt
		PRIMARY KEY (PersonalNr,ProjektNr),
	CONSTRAINT Fk_MitarbeiterProjekt_Personal
		FOREIGN KEY (PersonalNr)
		REFERENCES Mitarbeiter (PersonalNr),
	CONSTRAINT Fk_MitarbeiterProjekt_Projekt
		FOREIGN KEY (ProjektNr)
		REFERENCES Projekt (ProjektNr),

);