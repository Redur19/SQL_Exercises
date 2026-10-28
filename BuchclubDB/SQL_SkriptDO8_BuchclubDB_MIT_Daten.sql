USE master;

-- falls die DB vorhanden ist, löschen
DROP DATABASE IF EXISTS BuchclubDB;

-- Datenbank erstellen
CREATE DATABASE BuchclubDB;
GO
-- falls das Skript Probleme macht, die Authorisierung auf den Super User sa setzen
-- ALTER AUTHORIZATION ON DATABASE::BuchclubDB to sa

USE BuchclubDB;
GO

-- Anlegen der Tabellen
CREATE TABLE Buch (
	id INT NOT NULL,
	titel VARCHAR(100) NOT NULL,
	isbn CHAR(13) NOT NULL,
	CONSTRAINT pk_Buch
					PRIMARY KEY (id)
);
GO

CREATE TABLE Autor (
	id INT NOT NULL,
	vorname VARCHAR(40),
	nachname VARCHAR(40) NOT NULL,
	Geburtstag DATE,
	CONSTRAINT pk_Autor
					PRIMARY KEY (id)
);
GO

create table AutorBuch (autor_id int not null, buch_id int not null,
				CONSTRAINT pk_AutorBuch
								PRIMARY KEY (autor_id, buch_id),
				CONSTRAINT fk_AutorBuch_Autor
								FOREIGN KEY (autor_id) REFERENCES Autor (id),
				CONSTRAINT fk_AutorBuch_Buch
								FOREIGN KEY (buch_id) REFERENCES Buch (id)
);
GO

-- Datensätze für die Tabelle Autor
INSERT INTO Autor VALUES (1, 'Hans', 'Schmitt', '19910225');
-- 2. Datensatz, nicht alle Spalten, Null-Spalten können "leer" bleiben
INSERT INTO Autor (id, nachname) VALUES (2, 'Mueller');
-- 3. Datensatz
INSERT INTO Autor VALUES (3, 'Klaus', 'Walter', '19811031');

-- Datensätze für die Tabelle Buch
INSERT INTO Buch (id, titel, isbn) VALUES
(1, 'Reise nach Jerusalem', '1234567888121'),
(2, 'Höhepunkte am Mount Everest', '1234567888122'),
(3, 'Onkel Fritzs Biographie', '1234567888123');

-- Datensätze für die Zwischentabelle (Assoziationstabelle)
INSERT INTO AutorBuch (autor_id, buch_id) VALUES
(1,1),
(1,2),
(2,3),
(3,1);