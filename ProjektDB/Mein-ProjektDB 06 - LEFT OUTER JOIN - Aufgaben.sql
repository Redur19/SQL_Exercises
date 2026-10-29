-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:
USE ProjektDB;

-- Aufgabe 8.1
-- Zeigen Sie die Id, Firma und die Stadt aller Kunden
-- an. Zeigen Sie dazu außerdem den Namen der Abteilungen 
-- an, die am Ort des Kunden ihren Sitz haben (bilden Sie 
-- den Join über die Stadt).
--
--      id  firma                    stadt        bezeichnung
--      1   Im- und Export AG        München      Beratung
--      1   Im- und Export AG        München      Diagnose
--      1   Im- und Export AG        München      Einkauf
--      2   Technische Produkte oHG  Ulm          Verkauf
--      3   Frankreich-Reisen GmbH   Saarlouis    NULL
--      4   Getränke Schneider       Heidenheim   NULL
--      5   Finanzamt Ulm            Fürth        NULL
--      6   100% Sonderzeichen AG    Baden_Baden  NULL
SELECT k.*, ab.bezeichnung FROM Kunde k 
LEFT JOIN Abteilung ab ON ab.ort = k.ort;


-- Aufgabe 8.2
-- Ändern Sie die Abfrage aus Aufgabe 8.1, so dass alle
-- Abteilungen angezeigt werden, und dazu die passenden
-- Kunden im selben Ort.
--
--      id    firma                    stadt    bezeichnung
--      1     Im- und Export AG        München  Beratung
--      1     Im- und Export AG        München  Diagnose
--      NULL  NULL                     NULL     Freigabe
--      1     Im- und Export AG        München  Einkauf
--      2     Technische Produkte oHG  Ulm      Verkauf
SELECT k.*, ab.bezeichnung FROM Kunde k 
RIGHT JOIN Abteilung ab ON ab.ort = k.ort;


-- Aufgabe 8.3
-- Überarbeiten Sie die Abfrage aus der Aufgabe 8.1.
-- Statt NULL soll in der Spalte für die Abteilung der
-- Text '- k. A. -' angezeigt werden.
--
--      id  firma                    stadt        bezeichnung
--      1   Im- und Export AG        München      Beratung
--      1   Im- und Export AG        München      Diagnose
--      1   Im- und Export AG        München      Einkauf
--      2   Technische Produkte oHG  Ulm          Verkauf
--      3   Frankreich-Reisen GmbH   Saarlouis    - k. A. -
--      4   Getränke Schneider       Heidenheim   - k. A. -
--      5   Finanzamt Ulm            Fürth        - k. A. -
--      6   100% Sonderzeichen AG    Baden_Baden  - k. A. -



-- Aufgabe 8.4
--
-- Geben Sie eine Liste aller Kunden aus. Geben Sie zu den
-- Kunden auch das Projekt aus, sofern vorhanden.
--
--      firma                    stadt        bezeichnung
--      Im- und Export AG        München      Merkur
--      Technische Produkte oHG  Ulm          Ariane
--      Frankreich-Reisen GmbH   Saarlouis    Apollo
--      Getränke Schneider       Heidenheim   Pluto
--      Finanzamt Ulm            Fürth        Gemini
--      100% Sonderzeichen AG    Baden_Baden  NULL



-- Aufgabe 8.5
--
-- Geben Sie jetzt nur die Kunden aus, zu denen es kein
-- Projekt gibt.
--
--      firma                  stadt        bezeichnung
--      100% Sonderzeichen AG  Baden_Baden  NULL



-- Aufgabe 8.6
--
-- Geben Sie eine Liste der Kunden mit Firma und Stadt aus.
-- Geben Sie dazu die Nachnamen der Mitarbeiter aus, die
-- im selben Ort wohnen.
--
--      firma                   stadt       nachname
--      Im- und Export AG       München     Richter
--      Im- und Export AG       München     Vogel
--      Im- und Export AG       München     Schubert
--      Im- und Export AG       München     Keller
--      Technische Produkte oHG	Ulm	        Krüger
--      Technische Produkte oHG	Ulm	        Mozer

--      ...
--      (10 Zeilen)



-- Aufgabe 8.7
--
-- Geben Sie wieder die Liste der Kunden aus. Geben Sie
-- diesmal dazu die Anzahl Mitarbeiter aus, die am selben
-- Ort wohnen.
--
--      firma                    stadt        mitarbeiter
--      100% Sonderzeichen AG    Baden_Baden  0
--      Finanzamt Ulm            Fürth        1
--      Getränke Schneider       Heidenheim   1
--      Im- und Export AG        München      4
--      Frankreich-Reisen GmbH   Saarlouis    0
--      Technische Produkte oHG  Ulm          2



-- Aufgabe 8.8
--
-- Ergänzen Sie die Abfrage aus Aufgabe 8.7 und geben 
-- Sie zusätzlich noch die Anzahl Abteilungen aus, die
-- es am Ort des Kunden gibt.
--
--      firma                    stadt        mitarbeiter  abteilungen
--      100% Sonderzeichen AG    Baden_Baden  0            0
--      Finanzamt Ulm            Fürth        1            0
--      Getränke Schneider       Heidenheim   1            0
--      Im- und Export AG        München      4            3
--      Frankreich-Reisen GmbH   Saarlouis    0            0
--      Technische Produkte oHG  Ulm          2            1



-- Aufgabe 8.9
--
-- Zeigen Sie alle Mitarbeiter mit Id und nachname an
-- und geben Sie dazu die vom Mitarbeiter getätigten
-- Umsätze aus. Hat der Mitarbeiter noch keine Umsätze
-- getätigt, soll in der Spalte Umsatz 0 angezeigt werden.
--
--      id     nachname  umsatz
--      2581   Kaufmann  100000,00
--      5765   Schäfer   0,00
--      9031   Meier     0,00
--      9912   Wolf      0,00
--      10102  Huber     500,00
--      10102  Huber     500,00
--      ...
--      (36 Zeilen)



-- Aufgabe 8.10
--
-- Überarbeiten Sie die Abfrage aus Aufgabe 8.9.
-- Zeigen Sie diesmal nur die Mitarbeiter an, die
-- noch keine Umsätze getätigt haben.
--
--      id     nachname  umsatz
--      5765   Schäfer   0,00
--      9031   Meier     0,00
--      9912   Wolf      0,00
--      12121  Richter   0,00
--      18316  Müller    0,00
--      20204  Fuchs     0,00
--      ...
--      (11 Zeilen)



-- Aufgabe 8.11
--
-- Überarbeiten Sie die Abfrage aus Aufgabe 8.9.
-- Gruppieren Sie über die Mitarbeiter und geben 
-- Sie statt der einzelnen Umsätze die Summe der
-- Umsätze für jeden Mitarbeiter aus. Fehlende
-- Umsätze sollen weiterhin mit 0 angezeigt werden.
--
--      id     nachname  umsatz
--      2581   Kaufmann  100000,00
--      5765   Schäfer   0,00
--      9031   Meier     0,00
--      9912   Wolf      0,00
--      10102  Huber     18000,00
--      12121  Richter   0,00
--      ...
--      (15 Zeilen)



-- Aufgabe 8.12
--
-- Überarbeiten Sie die Abfrage aus Aufgabe 8.11.
-- Zeigen Sie nur die Mitarbeiter an, die weniger
-- als 100000 Umsatz erreicht haben.
--
--      id     nachname  umsatz
--      5765   Schäfer   0,00
--      9031   Meier     0,00
--      9912   Wolf      0,00
--      10102  Huber     18000,00
--      12121  Richter   0,00
--      17000  Krüger    20000,00
--      ...
--      (13 Zeilen)



-- Aufgabe 8.13
--
-- Zeigen Sie alle Mitarbeiter der Abteilung 'a2' mit 
-- Id und Nachname an und geben Sie dazu die vom Mitarbeiter 
-- getätigten Umsätze aus. Hat der Mitarbeiter noch keine 
-- Umsätze getätigt, soll in der Spalte Umsatz eine 0 
-- angezeigt werden.
--
--      id     nachname  umsatz
--      2581   Kaufmann  100000
--      9031   Meier     0
--      29346  Probst    0



-- Aufgabe 8.14
--
-- Zeigen Sie alle Mitarbeiter mit Id und Nachname an
-- und geben Sie dazu aus, an welchem Tag der Mitarbeiter
-- zum ersten Mal einen Umsatz erzielt hat und wann er
-- zum letzten Mal einen Umsatz erzielt hat.
--
--      id     nachname  erster      letzter
--      2581   Kaufmann  2019-05-01  2019-05-01
--      5765   Schäfer   NULL        NULL
--      9031   Meier     NULL        NULL
--      9912   Wolf      NULL        NULL
--      10102  Huber     2018-10-01  2019-01-01
--      12121  Richter   NULL        NULL
--      ...
--      (15 Zeilen)



-- Aufgabe 8.15
--
-- Listen Sie alle Mitarbeiter mit m_nr und m_name
-- auf. Zusätzlich soll das Projekt genannt werden,
-- in dem der Mitarbeiter Projektleiter ist. Sollte 
-- es kein passendes Projekt geben, soll '- k. A. -'
-- statt des Projektnamens angezeigt werden.
--
--      id     nachname  projekt
--      2581   Kaufmann  Merkur
--      5765   Schäfer   Pluto
--      9031   Meier     - k. A. -
--      9912   Wolf      - k. A. -
--      10102  Huber     Apollo
--      12121  Richter   - k. A. -
--      ...
--      (15 Zeilen)