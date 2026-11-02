-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:
USE ProjektDB;

-- Aufgabe 7.1
-- Finden Sie alle Abteilungen, an deren Standorten 
-- sich weitere Abteilungen befinden. Geben Sie jeweils
-- die Ids, Namen und Städte der Abteilungen aus.
--
--      id  kuerzel bezeichnung  ort		id	kuerzel bezeichnung    ort
--       1  BE		Beratung     München	1	BE		Beratung     München
--       2  DI		Diagnose     München	1	BE		Beratung     München
--       4  EK		Einkauf      München	1	BE		Beratung     München
--       1  BE		Beratung     München	2	DI		Diagnose     München
--       2  DI		Diagnose     München	2	DI		Diagnose     München
--       4  EK		Einkauf      München	2	DI		Diagnose     München
--      ...
--      (11 Zeilen)
SELECT * FROM Abteilung ab 
CROSS JOIN Abteilung a
WHERE a.ort = ab.ort;
--oder
SELECT * FROM Abteilung ab 
	INNER JOIN Abteilung a ON  a.ort = ab.ort;

-- Aufgabe 7.2
-- Überarbeiten Sie die Abfrage aus Aufgabe 7.1.
-- Diesmal sollen nur Zeilen ins Ergebnis übernommen 
-- werden, bei denen die Abteilungen sich unterscheiden.
--
--      id  kuerzel	bezeichnung  ort		id	kuerzel		bezeichnung  ort
--      1	BE		Beratung     München	2	DI			Diagnose     München
--      1	BE		Beratung     München	4	EK			Einkauf      München
--      2	DI		Diagnose     München	1	BE			Beratung     München
--      2	DI		Diagnose     München	4	EK			Einkauf      München
--      4	EK		Einkauf      München	1	BE			Beratung     München
--      4	EK		Einkauf      München	2	DI			Diagnose     München
SELECT * FROM Abteilung ab 
CROSS JOIN Abteilung a
WHERE a.ort = ab.ort AND a.id != ab.id;
--oder
SELECT * FROM Abteilung ab 
	INNER JOIN Abteilung a ON  a.ort = ab.ort AND a.id != ab.id;

-- Aufgabe 7.3
-- Überarbeiten Sie die Abfrage aus Aufgabe 7.2.
-- Diesmal soll jede Kombination nur einmal angezeigt 
-- werden. D.h. A-B ist das gleiche wie B-A.
--
--      id	kuerzel	bezeichnung  ort		id	kuerzel	bezeichnung  ort
--      2	DI		Diagnose     München	1	BE		Beratung     München
--      4	EK		Einkauf      München	1	BE		Beratung     München
--      4	EK		Einkauf      München	2	DI		Diagnose     München
SELECT * FROM Abteilung ab 
CROSS JOIN Abteilung a
WHERE a.ort = ab.ort AND a.id != ab.id AND a.id <= ab.id ;
--oder
SELECT * FROM Abteilung ab 
	INNER JOIN Abteilung a ON  a.ort = ab.ort AND a.id != ab.id AND a.id <= ab.id;
--man kann hier die Bedingungen mit WHERE schreiben

-- Aufgabe 7.4
-- Finden Sie heraus, ob es Mitarbeiter gibt, die einen 
-- Kollegen oder eine Kollegin aus derselben Abteilung 
-- in ihrem Wohnort haben (Stichwort Fahrgemeinschaft).
--
--      id		vorname  nachname	abt_id  ort			chef_id
--      5765    Sabine	 Schäfer    3		Landshut	2581
--      10102   Petra	 Huber		3		Landshut	2581
--      12121   Ursula	 Richter	4		München		22222
--      22222   Anke	 Vogel		4		München		NULL
SELECT m.* FROM Mitarbeiter M 
	JOIN Mitarbeiter mi ON mi.id != m.id
WHERE mi.abt_id=m.abt_id AND mi.ort =m.ort;


-- Aufgabe 7.5
-- Geben Sie die Mitarbeiter-Id, die Projektnummer und 
-- die Aufgabe der Mitarbeiter aus, die im gleichen 
-- Projekt die gleiche Aufgabe ausführen. Sortieren Sie
-- die Ausgabe ggf. sinnvoll.
--
--      mit_id  pro_id  aufgabe
--      25348   2      Sachbearbeiter
--      28559   2      Sachbearbeiter
--      20204   4      Sachbearbeiter
--      27365   4      Sachbearbeiter
SELECT a.mit_id, a.pro_id, a.aufgabe FROM Arbeit a 
	JOIN Arbeit ar ON a.mit_id != ar.mit_id
WHERE a.pro_id=ar.pro_id AND ar.aufgabe =a.aufgabe
ORDER BY a.pro_id , mit_id;
