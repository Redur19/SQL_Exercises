-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:

USE ProjektDB;
-- Aufgabe 10.1
-- Erstellen Sie eine Liste mit allen Städten, in
-- denen entweder ein Mitarbeiter wohnt oder aber
-- eine Abteilung ihren Sitz hat. Jede Stadt soll
-- nur einmal angezeigt werden.
--
--      ort
--      NULL
--      Augsburg
--      Fürth
--      Heidenheim
--      Landshut
--      München
--      ...
--      (9 Zeilen)
SELECT ort 
FROM Mitarbeiter 
UNION
SELECT ort 
FROM Abteilung;


-- Aufgabe 10.2
-- Erstellen Sie eine Liste mit allen Städten, in
-- denen entweder Mitarbeiter wohnen oder Kunden
-- Ihren Sitz haben. Doppelte Einträge sollen nicht
-- weggefiltert werden.
--
--      ort
--      NULL
--      Landshut
--      NULL
--      Heidenheim
--      Landshut
--      München
--      ...
--      (21 Zeilen)
SELECT ort 
FROM Mitarbeiter 
UNION ALL
SELECT ort 
FROM Kunde;



-- Aufgabe 10.3
-- Geben Sie die Liste aus Aufgabe 10.2 jetzt sortiert
-- nach dem Städtenamen aus.
--
--      ort
--      NULL
--      NULL
--      NULL
--      Augsburg
--      Baden_Baden
--      Fürth
--      ...
--      (21 Zeilen)
SELECT ort 
FROM Mitarbeiter 
UNION ALL
SELECT ort 
FROM Kunde
ORDER BY ort;



-- Aufgabe 10.4
-- Finden Sie die Ids der Mitarbeiter, die entweder 
-- der Abteilung 1 angehören oder nach dem 1.1.2019 
-- in ihr Projekt eingetreten sind. Die Ids sollen 
-- aufsteigend sortiert ausgegeben werden.
--
--      id
--      2581
--      9031
--      9912
--      17000
--      18316
--      28559
--      29346
SELECT id 
FROM Mitarbeiter
where abt_id = 1
UNION
SELECT mit_id 
FROM Arbeit 
WHERE einst_dat > '20190101';


-- Aufgabe 10.5
-- Die Wohnorte der Mitarbeiter und die Standorte 
-- der Abteilungen sollen ausgewertet werden:
--
-- a) Zeigen Sie, an welchen Orten entweder
--    Mitarbeiter wohnen oder Abteilungen sind.
-- b) Zeigen Sie, an welchen Orten sowohl Mitarbeiter
--    als auch Abteilungen sind.
-- c) Zeigen Sie, an welchen Orten Mitarbeiter
--    wohnen, aber keine Abteilungen sind
-- d) Zeigen Sie, an welchen Orten Abteilungen sind,
--    aber keine Mitarbeiter wohnen.
--
--  a) ort         b) ort    c)   ort       d)   ort
--     NULL           München     NULL           Stuttgart
--     Augsburg       Ulm         Augsburg
--     Fürth                      Fürth
--     Heidenheim                 Heidenheim
--     Landshut                   Landshut
--     München                    Rosenheim
--     Rosenheim
--     Stuttgart
--     Ulm
--a)
SELECT ort FROM Mitarbeiter UNION SELECT ort FROM Abteilung;
--b)
SELECT ort FROM Mitarbeiter INTERSECT SELECT ort FROM Abteilung;
--c)
SELECT ort FROM Mitarbeiter EXCEPT SELECT ort FROM Abteilung;
--d)
SELECT ort FROM Abteilung EXCEPT SELECT ort FROM Mitarbeiter;


-- Aufgabe 10.6
-- Erstellen Sie eine Liste der Mitarbeiter, die
-- sowohl im Projekt 1 als auch im Projekt 3
-- arbeiten.
--
--      vorname  nachname
--      Petra    Huber
--      Rainer   Meier
SELECT vorname, nachname 
FROM Mitarbeiter m
	JOIN Arbeit a ON a.mit_id=m.id
WHERE a.pro_id = 3
INTERSECT 
SELECT vorname, nachname 
FROM Mitarbeiter m
	JOIN Arbeit a ON a.mit_id=m.id
WHERE a.pro_id = 1;

-- Aufgabe 10.7
-- Erstellen Sie eine Liste der Mitarbeiter, die in den
-- Projekten 4 und 5 arbeiten und weniger als 4000
-- verdienen.
--  a)  Nutzen Sie den INTERSECT-Operator
--  b)  Nutzen Sie den EXCEPT-Operator
--
--      vorname  nachname
--      Dirk     Fuchs
--      Klaus    Wolf
--      Lena     Albrecht
--      Ursula   Richter

--  a)  Nutzen Sie den INTERSECT-Operator
SELECT vorname, nachname 
FROM Mitarbeiter m
	JOIN Arbeit a ON a.mit_id=m.id
WHERE a.pro_id IN (4,5) 
INTERSECT 
SELECT vorname, nachname 
FROM Mitarbeiter m
	JOIN Arbeit a ON a.mit_id=m.id
	join Gehalt g ON g.mit_id=m.id
WHERE gehalt < 4000;

--  b)  Nutzen Sie den EXCEPT-Operator
SELECT vorname, nachname 
FROM Mitarbeiter m
	JOIN Arbeit a ON a.mit_id=m.id
WHERE a.pro_id IN (4,5) 
EXCEPT 
SELECT vorname, nachname 
FROM Mitarbeiter m
	join Gehalt g ON g.mit_id=m.id
WHERE gehalt >= 4000;

-- Aufgabe 10.8
-- Erstellen Sie eine Liste aller Mitarbeiter, kombiniert
-- mit einer Liste aller Kunden. Geben Sie Firma bzw. Namen
-- und die Stadt aus.

--      firma                  ort
--      100% Sonderzeichen AG  Baden_Baden
--      Andreas Probst         Augsburg
--      Anke Vogel             München
--      Brigitte Kaufmann      NULL
--      Dirk Fuchs             Fürth
--      Finanzamt Ulm          Fürth
--      ...
--      (21 Zeilen)
SELECT firma, ort 
FROM Kunde 
UNION 
SELECT (vorname + ' ' + nachname) AS name, ort 
--CONCAT hab neu gelernt CONCAT(vorname,' ',nachname) AS name
FROM Mitarbeiter m
ORDER BY firma;

-- Aufgabe 10.9
-- Erweitern Sie die Abfrage aus Aufgabe 10.8 und geben
-- Sie auch noch die Abteilungen mit Bezeichnung und
-- Stadt in der Liste aus.
--
--      bezeichnung            ort
--      100% Sonderzeichen AG  Baden_Baden
--      Andreas Probst         Augsburg
--      Anke Vogel             München
--      Beratung               München
--      Brigitte Kaufmann      NULL
--      Diagnose               München
--      ...
--      (26 Zeilen)
SELECT firma AS bezeichnung, ort 
FROM Kunde 
UNION --ALL brauche ich hier nicht weil die so wie so ungleicht Werte und Bezeichnungen sind
SELECT CONCAT(vorname,' ',nachname) AS name , ort
FROM Mitarbeiter m
UNION 
SELECT bezeichnung, ort
FROM Abteilung
ORDER BY firma;


-- Aufgabe 10.10

-- Um die Übersichtlichkeit zu erhöhen, soll in der
-- Liste markiert werden, ob es sich um eine Abteilung,
-- einen Mitarbeiter oder einen Kunden handelt.
--
--      bezeichnung            ort          kategorie
--      100% Sonderzeichen AG  Baden_Baden  Kunde
--      Andreas Probst         Augsburg     Mitarbeiter
--      Anke Vogel             München      Mitarbeiter
--      Beratung               München      Abteilung
--      Brigitte Kaufmann      NULL         Mitarbeiter
--      Diagnose               München      Abteilung
--      ...
--      (26 Zeilen)

SELECT firma AS bezeichnung, ort ,'Kunde' AS kategorie
FROM Kunde 
UNION --ALL brauche ich hier nicht weil die so wie so ungleicht Werte und Bezeichnungen sind
SELECT CONCAT(vorname,' ',nachname) AS name , ort ,'Mitarbeiter' --AS kategorie ohne AS geht es auch
FROM Mitarbeiter m
UNION  
SELECT bezeichnung, ort, 'Abteilung' --AS kategorie ohne AS geht es auch
FROM Abteilung
ORDER BY firma;
