-- Datenbank erstellen
CREATE DATABASE testdb;

-- Datenbank auswählen
USE testdb;

-- Tabelle erstellen
CREATE TABLE testTable (
	id INT,
	vorname VARCHAR(50),
	nachname VARCHAR(50),
	geburt DATE
);

CREATE TABLE testTable2 (
	id INT IDENTITY(10000, 10) PRIMARY KEY,
	vorname VARCHAR(50) NOT NULL,
	nachname VARCHAR(50) NOT NULL,
	geburt DATE NULL
);

-- Drei Tabellen mit Beziehungen
CREATE TABLE author (
	id INT IDENTITY CONSTRAINT pk_author PRIMARY KEY,
	firstname VARCHAR(50) NOT NULL,
	lastname VARCHAR(50) NOT NULL
);

CREATE TABLE book (
	isbn CHAR(13) CONSTRAINT pk_book PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	price MONEY NULL
);

CREATE TABLE authorbook (
	author_id INT,
	isbn CHAR(13),
	CONSTRAINT pk_authorbook 
		PRIMARY KEY (author_id, isbn),
	CONSTRAINT fk_authorbook_author
		FOREIGN KEY (author_id)
		REFERENCES author (id),
	CONSTRAINT pk_authorbook_book
		FOREIGN KEY (isbn)
		REFERENCES book (isbn)
);

