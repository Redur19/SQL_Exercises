-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:
USE ProjektDB;
BEGIN TRANSACTION;
SET LANGUAGE german;
ROLLBACK TRANSACTION;

-- ==========
-- Funktionen
-- ==========

-- Aufgabe 9.6
-- Geben Sie den Vor- und Nachnamen der Mitarbeiter
-- in einer Spalte aus. Nutzen Sie die Funktionen
-- CONCAT() und TRIM().
--
--      name
--      Brigitte Kaufmann
--      Sabine Schäfer
--      Rainer Meier
--      Klaus Wolf
--      Petra Huber
--      Ursula Richter
--      ...
--      (15 Zeilen)
SELECT CONCAT(TRIM(vorname),' ',TRIM(nachname)) AS 'name'
FROM Mitarbeiter;


-- Aufgabe 9.7
-- Geben Sie den Vor- und Nachnamen der Mitarbeiter,
-- gefolgt vom Wohnort in einer Spalte aus. Wenn kein
-- Wohnort vorhanden ist, soll der Text 'unbekannt'
-- erscheinen.
--
--      mitarbeiter
--      Brigitte Kaufmann, unbekannt
--      Sabine Schäfer, Landshut
--      Rainer Meier, unbekannt
--      Klaus Wolf, Heidenheim
--      Petra Huber, Landshut
--      Ursula Richter, München
--      ...
--      (15 Zeilen)
SELECT CONCAT(TRIM(vorname),' ',TRIM(nachname),', ',ISNULL(ort, 'unbekannt')) AS 'mitarbeiter'
FROM Mitarbeiter;



-- Aufgabe 9.8
-- Geben Sie die Kurzform des Mitarbeiternamens
-- in einer Spalte aus. Das erste Zeichen eines
-- Textes können Sie mit LEFT() oder SUBSTRING()
-- ermitteln.
--
--      name
--      B. Kaufmann
--      S. Schäfer
--      R. Meier
--      K. Wolf
--      P. Huber
--      U. Richter
--      ...
--      (15 Zeilen)
SELECT CONCAT(LEFT(vorname,1),'. ',TRIM(nachname)) AS 'name'
FROM Mitarbeiter;


-- Aufgabe 9.9
-- Geben Sie die Nachnamen der Mitarbeiter aus und sortieren
-- Sie die Ausgabe nach der Länge der Namen aufsteigend. Bei
-- gleicher Länge des Namens soll alphabetisch absteigend
-- sortiert werden.
--
--      nachname
--      Wolf
--      Vogel
--      Mozer
--      Meier
--      Huber
--      Fuchs
--      ...
--      (15 Zeilen)
SELECT nachname
FROM Mitarbeiter
ORDER BY LEN(nachname)ASC , nachname DESC;


-- Aufgabe 9.10
-- Zeigen Sie die Namen aller Mitarbeiter an und geben Sie
-- dazu die Position des ersten Vokals an. Nutzen Sie die
-- Funktion PATINDEX() um den Vokal zu finden.
--
--      nachname  erster_vokal
--      Kaufmann  2
--      Schäfer   4
--      Meier     2
--      Wolf      2
--      Huber     2
--      Richter   2
--      ...
--      (15 Zeilen)
SELECT nachname, PATINDEX('%[aeiouüäö]%',nachname) AS erster_vokal 
FROM Mitarbeiter


-- Aufgabe 9.11
-- Berechnen Sie die Anzahl der Tage (brutto), die Sie bereits
-- in diesem Modul verbringen durften (oder mussten). Nutzen Sie
-- die Funktionen DATEDIFF() und GETDATE().
--
--      tage_in_modul
--      8
SELECT DATEDIFF(DAY,'20261026',GETDATE()) AS tage_in_modul


-- Aufgabe 9.12
-- Schreiben Sie eine Abfrage, die das heutige Datum formatiert
-- ausgibt. Nutzen Sie dazu die Datumsfunktionen DATENAME(),
-- DATEPART() und GETDATE() sowie die Funktion CONCAT().
--
--      datum_formatiert
--      Heute ist Dienstag, der 03. November des Jahres 2026 in der 35. Kalenderwoche
SELECT CONCAT('Heute ist ',DATENAME(dw,GETDATE()),', der ', 
				DATENAME(DAY,GETDATE()),'. ',DATENAME(month,GETDATE()),' des Jahres ',
				YEAR(GETDATE()),' in der ', DATENAME(WEEK,GETDATE()),' Kalenderwoche'
				) AS datum_formatiert


-- Aufgabe 9.13
-- Der wievielte Tag des Jahres ist heute?
--
--      datum       tag_des_jahres
--      2026-11-03  307
SELECT CAST(GETDATE() AS DATE) AS datum, DATEPART(DAYOFYEAR, GETDATE()) AS tag_des_jahres


-- Aufgabe 9.14
-- Kategorisieren Sie Ihre Mitarbeiter. Mitarbeiter, die ein
-- Gehalt unter 4000 bekommen sind Kategorie A, die anderen
-- sind Kategorie B. Versuchen Sie IIF() statt CASE zu verwenden.
--
--      mit_id  gehalt   kategorie
--      2581    3000,00  A
--      5765    4500,00  B
--      9031    4000,00  B
--      9912    3500,00  A
--      10102   3500,00  A
--      12121   3000,00  A
SeLECT mit_id, gehalt, 'A' AS kategorie
FROM Gehalt
WHERE gehalt < 4000
UNION
SeLECT mit_id, gehalt, 'B' AS kategorie
FROM Gehalt
WHERE gehalt >= 4000
ORDER BY mit_id;
--oder
SeLECT mit_id, gehalt, IIF(gehalt < 4000,'A','B')AS kategorie
FROM Gehalt;

