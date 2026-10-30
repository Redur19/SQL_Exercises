-- Nutzen Sie die ProjektDB-Datenbank, um die folgenden
USE ProjektDB;
-- Aufgabe 6.1
-- Schreiben Sie eine Abfrage, die alle Mitarbeiter aus der 
-- Abteilung a4 ausgibt. Geben Sie die Felder vorname, nachname
-- und Abteilungsname aus.
--      vorname  nachname  bezeichnung
--      Klaus    Wolf      Einkauf
--      Ursula   Richter   Einkauf
--      Dirk     Fuchs     Einkauf
--      Anke     Vogel     Einkauf
SELECT m.vorname, m.nachname, ab.bezeichnung
FROM Mitarbeiter m
INNER JOIN Abteilung ab ON ab.id =m.abt_id
WHERE ab.id=4;

-- Aufgabe 6.2
-- Schreiben Sie eine Abfrage, die alle Projekte mit den 
-- zugehörigen Projektleitern ausgibt. Geben Sie alle Daten 
-- aus der Projekt-Tabelle und zusätzlich Id und Einstell-
-- Datum aus der Arbeit-Tabelle aus. Sortieren Sie das
-- Ergebnis nach der Projekt-ID.
--      id  bezeichnung  mittel     kd_id  mit_id  einst_dat
--      p1  Apollo       120000,00  3      10102   2018-10-01
--      p3  Merkur       186500,00  1      2581    2019-10-15
--      p4  Pluto        88500,00   4      5765    2018-07-20
--      p5  Ariane       165000,00  2      22222   2019-01-01
SELECT p.*, a.mit_id, a.einst_dat 
FROM Projekt p
	JOIN Arbeit a ON a.pro_id = p.id
WHERE a.aufgabe='Projektleiter'
ORDER BY p.id;

-- Aufgabe 6.3
-- Verändern Sie die Abfrage aus Aufgabe 6.2, indem Sie statt der
-- Mitarbeiter-Id den Nachnamen des Mitarbeiters in das Ergebnis 
-- einbauen.

--      id  bezeichnung  mittel     kd_id  nachname  einst_dat
--      p1  Apollo       120000,00  3      Huber     2018-10-01
--      p3  Merkur       186500,00  1      Kaufmann  2019-10-15
--      p4  Pluto        88500,00   4      Schäfer   2018-07-20
--      p5  Ariane       165000,00  2      Vogel     2019-01-01
SELECT p.*, a.mit_id,m.nachname, a.einst_dat 
FROM Projekt p
	JOIN Arbeit a ON a.pro_id = p.id
	JOIN Mitarbeiter m On m.id=a.mit_id
WHERE a.aufgabe='Projektleiter'
ORDER BY p.id;

-- Aufgabe 6.4
-- Erweitern Sie die Abfrage aus Aufgabe 6.3, indem Sie zusätzlich
-- die Bezeichnung der Abteilung in das Ergebnis einbauen.
--      id  bezeichnung  mittel     kd_id  nachname  einst_dat   bezeichnung
--      p1  Apollo       120000,00  3      Huber     2018-10-01  Freigabe
--      p3  Merkur       186500,00  1      Kaufmann  2019-10-15  Diagnose
--      p4  Pluto        88500,00   4      Schäfer   2018-07-20  Freigabe
--      p5  Ariane       165000,00  2      Vogel     2019-01-01  Einkauf
SELECT p.*, a.mit_id,m.nachname, a.einst_dat ,ab.bezeichnung
FROM Projekt p
	JOIN Arbeit a ON a.pro_id = p.id
	JOIN Mitarbeiter m On m.id=a.mit_id
	JOIN Abteilung ab ON ab.id= m.abt_id
WHERE a.aufgabe='Projektleiter'
ORDER BY p.id;

-- Aufgabe 6.5
-- Erstellen Sie eine Abfrage, die die Mitarbeiter mit allen
-- zusätzlichen Informationen zu Abteilung, Gehalt, Arbeit und 
-- Projekt ausgibt. Geben Sie dabei keine Spalten doppelt im 
-- Ergebnis aus.
--      id     nachname  vorname   abt_id  stadt       bezeichnung  stadt      gehalt   aufgabe         einst_dat   bezeichnung  kd_id
--      2581   Kaufmann  Brigitte  a2      NULL        Diagnose     München    3000,00  Projektleiter   2019-10-15  Merkur       1
--      5765   Schäfer   Sabine    a3      Landshut    Freigabe     Stuttgart  4500,00  Projektleiter   2018-07-20  Pluto        4
--      9031   Meier     Rainer    a2      NULL        Diagnose     München    4000,00  Gruppenleiter   2019-04-15  Apollo       3
--      9031   Meier     Rainer    a2      NULL        Diagnose     München    4000,00  Sachbearbeiter  2018-11-15  Merkur       1
--      9912   Wolf      Klaus     a4      Heidenheim  Einkauf      München    3500,00  Sachbearbeiter  2019-01-17  Ariane       2
--      10102  Huber     Petra     a3      Landshut    Freigabe     Stuttgart  3500,00  Projektleiter   2018-10-01  Apollo       3
--      ...
--      (20 Zeilen)
SELECT m.id, m.nachname, m.vorname, m.abt_id,  m.ort AS stadt, ab.bezeichnung, ab.ort AS stadt,
			g.gehalt, a.aufgabe, a.einst_dat, p.bezeichnung,  p.kunde_id 
FROM Mitarbeiter m
JOIN Abteilung ab ON ab.id = m.abt_id
JOIN Gehalt g ON g.mit_id =m.id
JOIN Arbeit a ON a.mit_id= m.id
JOIN Projekt p ON p.id =a.pro_id;

-- Aufgabe 6.6
-- Geben Sie für die Projekte die mit "A" beginnen die unten
-- gezeigten Informationen aus. Sortieren Sie die Ausgabe 
-- nach dem Projektnamen aufsteigend und der Mitarbeiter-Id 
-- absteigend.
--      bezeichnung  firma                    mit_id  aufgabe
--      Apollo       Frankreich-Reisen GmbH   29346   Sachbearbeiter
--      Apollo       Frankreich-Reisen GmbH   28559   NULL
--      Apollo       Frankreich-Reisen GmbH   17000   NULL
--      Apollo       Frankreich-Reisen GmbH   10102   Projektleiter
--      Apollo       Frankreich-Reisen GmbH   9031    Gruppenleiter
--      Ariane       Technische Produkte oHG  22222   Projektleiter
--      Ariane       Technische Produkte oHG  17000   NULL
--      Ariane       Technische Produkte oHG  9912    Sachbearbeiter 
SELECT p.bezeichnung, k.firma, a.mit_id, a.aufgabe
FROM Projekt p
	JOIN Kunde k ON k.id = p.kunde_id
	JOIN Arbeit a ON a.pro_id= p.id
WHERE p.bezeichnung LIKE 'A%'
ORDER BY p.bezeichnung ASC , a.mit_id DESC;

-- Aufgabe 6.7
-- Finden Sie Namen und Vornamen aller Mitarbeiter, 
-- die im Projekt Merkur arbeiten.
--      nachname  vorname
--      Kaufmann  Brigitte            
--      Meier     Rainer              
--      Huber     Petra 
--      Schubert  Rolf
SELECT m.nachname, m.vorname
FROM Mitarbeiter m
	JOIN Arbeit a ON m.id=a.mit_id
	JOIN Projekt p ON p.id= a.pro_id
WHERE p.bezeichnung='Merkur';

-- Aufgabe 6.8
-- Nennen Sie Namen und Vornamen aller Projektleiter, deren 
-- Abteilung den Standort München hat.
--      nachname  vorname
--      Kaufmann  Brigitte
--      Vogel     Anke
SELECT m.nachname, m.vorname
FROM Mitarbeiter m
	JOIN Arbeit a ON m.id=a.mit_id
	JOIN Abteilung ab ON ab.id= m.abt_id
WHERE a.aufgabe='Projektleiter' AND ab.ort ='München';

-- Aufgabe 6.9
-- Nennen Sie einmalig die Namen der Projekte, in denen die
-- Mitarbeiter arbeiten, die ein Gehalt von mindestens
-- 5.000 € beziehen.
--      pr_name
--      Apollo
--      Ariane
--      Gemini
SELECT DISTINCT p.bezeichnung AS pr_name
FROM Projekt p
	JOIN Arbeit a ON a.pro_id= p.id
	JOIN Gehalt g ON g.mit_id=a.mit_id
WHERE g.gehalt>= 5000;

-- Aufgabe 6.10
-- Erstellen Sie das Kartesische Produkt auf Mitarbeiter- und Abteilungs-Tabelle
--      id     nachname  vorname   abt_id  stadt       id  bezeichnung  stadt
--      2581   Kaufmann  Brigitte  a2      NULL        a1  Beratung     München
--      5765   Schäfer   Sabine    a3      Landshut    a1  Beratung     München
--      9031   Meier     Rainer    a2      NULL        a1  Beratung     München
--      9912   Wolf      Klaus     a4      Heidenheim  a1  Beratung     München
--      10102  Huber     Petra     a3      Landshut    a1  Beratung     München
--      12121  Richter   Ursula    a4      München     a1  Beratung     München
--      ...
--      (75 Zeilen)

SELECT * FROM Mitarbeiter m
CROSS JOIN Abteilung ab ;

-- Aufgabe 6.11
-- Finden Sie alle Mitarbeiter und dazu alle Abteilungen, in denen
-- diese Mitarbeiter NICHT arbeiten.
--      id     nachname  vorname   abt_id  stadt       id  bezeichnung  stadt
--      2581   Kaufmann  Brigitte  a2      NULL        a1  Beratung     München
--      5765   Schäfer   Sabine    a3      Landshut    a1  Beratung     München
--      9031   Meier     Rainer    a2      NULL        a1  Beratung     München
--      9912   Wolf      Klaus     a4      Heidenheim  a1  Beratung     München
--      10102  Huber     Petra     a3      Landshut    a1  Beratung     München
--      12121  Richter   Ursula    a4      München     a1  Beratung     München
--      ...
--      (60 Zeilen)
--Diese Lösung ist genau wie in der Aufgabentabelle
SELECT m.id, m.nachname, m.vorname, m.abt_id,  m.ort AS stadt, ab.id, ab.bezeichnung, ab.ort 
FROM Mitarbeiter m
CROSS JOIN Abteilung ab 
Where ab.id <> m.abt_id;
--alternativ
SELECT * FROM Mitarbeiter m 
	CROSS JOIN Abteilung ab
WHERE ab.id != m.abt_id; 
--oder
SELECT * FROM Mitarbeiter m 
	 JOIN Abteilung ab ON ab.id != m.abt_id;

-- Aufgabe 6.12
-- Nennen Sie die Abteilungsnamen der Mitarbeiter, die
-- am 01.01.2019 eingestellt wurden.
--		bezeichnung
--		Freigabe
--		Einkauf
SELECT ab.bezeichnung
FROM Abteilung ab 
	JOIN Mitarbeiter m ON m.abt_id=ab.id
	JOIN Arbeit a ON a.mit_id=m.id
WHERE a.einst_dat='20190101';

-- Aufgabe 6.13
-- Nennen Sie Namen und Vornamen aller Projektleiter, deren
-- Abteilung den Standort Stuttgart hat.
--      nachname  vorname
--      Schäfer   Sabine
--      Huber     Petra
SELECT m.nachname, m.vorname
FROM Mitarbeiter m
	JOIN Arbeit a ON m.id=a.mit_id
	JOIN Abteilung ab ON ab.id= m.abt_id
WHERE a.aufgabe='Projektleiter' AND ab.ort ='Stuttgart';

-- Aufgabe 6.14
-- Nennen Sie einmalig die Namen der Projekte, in denen
-- Mitarbeiter arbeiten, die zur Abteilung Beratung gehören.
--      bezeichnung
--      Apollo
--      Gemini
SELECT DISTINCT p.bezeichnung
FROM Projekt p
	JOIN Arbeit a ON a.pro_id = p.id
	JOIN Mitarbeiter m On m.id=a.mit_id
	JOIN Abteilung ab ON ab.id= m.abt_id
WHERE ab.bezeichnung='Beratung';

-- Aufgabe 6.15
-- Nennen Sie die Kunden, an deren Projekten Mitarbeiter
-- arbeiten, die mindestens 5.000 € Gehalt bekommen. Nennen
-- Sie zu den Kunden auch die Anzahl dieser Mitarbeiter.
--      firma                    mitarbeiter
--      Finanzamt Ulm            2
--      Frankreich-Reisen GmbH   2
--      Technische Produkte oHG  1
SELECT k.firma, COUNT (a.mit_id) AS mitarbeiter 
--COUNT ist eine Aggregatfunktion, dann muss nach 'k.firma' groupiert werden.
FROM Kunde k
	JOIN Projekt p ON k.id = p.kunde_id
	JOIN Arbeit a ON a.pro_id= p.id
	JOIN Gehalt g ON g.mit_id=a.mit_id
WHERE g.gehalt >= 5000
GROUP BY k.firma;
