-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:

USE ProjektDB;
-- ======================
-- Einfache Unterabfragen
-- ======================

-- Aufgabe 5.1
-- Nennen Sie Personalnummer und Name des Mitarbeiters 
-- mit der kleinsten Personalnummer. Nutzen Sie eine 
-- einfache Unterabfrage.
--
--      id    nachname
--      2581  Kaufmann
select id, nachname From Mitarbeiter
where id in (select MIN(id) From Mitarbeiter);

-- Aufgabe 5.2
-- Nennen Sie die Abteilungsnummern der Mitarbeiter, die 
-- in Projekt p3 arbeiten. Nutzen Sie eine einfache 
-- Unterabfrage.
--
--      abt_id
--      a2
--      a2
--      a3
--      a5

select abt_id From Mitarbeiter 
where id in (select mit_id From Arbeit
			WHERE pro_id = 3);


-- Aufgabe 5.3
-- Erstellen Sie eine Liste der Ids aller Mitarbeiter, 
-- deren Gehalt über dem  Durchschnitt liegt. Nutzen 
-- Sie eine einfache Unterabfrage.
--
--      mit_id
--      5765
--      9031
--      17000
--      22222
--      28559
--      29346
select mit_id FROM Gehalt
WHERE gehalt >(select AVG(gehalt) FROM Gehalt);

-- Aufgabe 5.4
-- Nennen Sie die Nummern aller Projekte, in denen Mitarbeiter
-- arbeiten, deren Personalnummer kleiner als die Nummer des 
-- Mitarbeiters namens Müller ist. Nutzen Sie eine einfache 
-- Unterabfrage.
--
--      pro_id
--      p1
--      p3
--      p4
--      p5
select DISTINCT pro_id FROM Arbeit
WHERE mit_id < (select id FROM Mitarbeiter
							where nachname='Müller');



-- Aufgabe 5.5
-- Nennen Sie die Namen aller Mitarbeiter, die in einer 
-- Abteilung in Ulm arbeiten. Nutzen Sie eine einfache 
-- Unterabfrage.
--
--      nachname  vorname
--      Krüger    Martin
--      Schubert  Rolf
--      Albrecht  Lena
select nachname, vorname FROM Mitarbeiter
WHERE abt_id IN (SELECT id FROM Abteilung
				WHERE ort ='Ulm');

-- Aufgabe 5.6
-- Finden Sie die Personalnummer des Projektleiters, 
-- der in dieser Position als letzter einstellt wurde.
-- Nutzen Sie eine einfache Unterabfrage.
--
--      mit_id
--      2581
SELECT mit_id FROM Arbeit
WHERE einst_dat IN (SELECT TOP (1) einst_dat FROM Arbeit
					WHERE aufgabe = 'Projektleiter' 
					ORDER BY einst_dat DESC);

-- Aufgabe 5.7
-- Nennen Sie die Namen aller Mitarbeiter, die im Projekt "Apollo" 
-- arbeiten. Nutzen Sie zwei verschachtelte Unterabfragen.
--
--      nachname
--      Meier
--      Huber
--      Krüger
--      Mozer
--      Probst
SELECT nachname FROM Mitarbeiter
WHERE id IN (SELECT mit_id FROM Arbeit
			WHERE pro_id IN (SELECT id FROM Projekt
							WHERE bezeichnung ='Apollo'))


-- Aufgabe 5.8
-- Zeigen Sie Abteilungsnummer und den Namen der Abteilungen 
-- für die Mitarbeiter an, die am Projekt "Apollo" mitarbeiten. 
-- Nutzen Sie drei verschachtelte Unterabfragen.
--
--      id  bezeichnung
--      a1  Beratung
--      a2  Diagnose
--      a3  Freigabe
--      a5  Verkauf
SELECT id,bezeichnung FROM Abteilung
WHERE id IN(SELECT abt_id FROM Mitarbeiter
			WHERE id IN(SELECT mit_id FROM Arbeit
						WHERE pro_id IN(SELECT id FROM Projekt
										WHERE bezeichnung='Apollo')));

-- =========================
-- Korrelierte Unterabfragen
-- =========================
SELECT * FROM Arbeit
-- Aufgabe 5.9
-- Geben Sie eine Liste der Projekt-Ids und Aufgaben aus und 
-- nennen Sie dazu den Namen des Mitarbeiters. Soertieren Sie
-- die Ausgabe nach Projekt-Id und Aufgabe. Nutzen Sie eine
-- korrelierte Unterabnfrage im SELECT. 20 Datensätze
--
--      pro_id  aufgabe         nachname
--      p1      NULL            Krüger
--      p1      NULL            Mozer
--      p1      Gruppenleiter   Meier
--      p1      Projektleiter   Huber
--      p1      Sachbearbeiter  Probst
--      p2      NULL            Probst
SELECT pro_id, aufgabe ,(SELECT nachname FROM Mitarbeiter m
						WHERE a.mit_id =m.id) AS nachname
FROM Arbeit a
ORDER BY pro_id, aufgabe ASC;


-- Aufgabe 5.10
-- Erweitern Sie die Abfrage aus Aufgabe 5.9 und geben Sie
-- zusätzlich auch den Projektnamen aus. Nutzen Sie zwei
-- korrelierte Unterabfragen im SELECT.
--
--      pro_id  bezeichnung  aufgabe         nachname
--      p1      Apollo       NULL            Krüger
--      p1      Apollo       NULL            Mozer
--      p1      Apollo       Gruppenleiter   Meier
--      p1      Apollo       Projektleiter   Huber
--      p1      Apollo       Sachbearbeiter  Probst
--      p2      Gemini       NULL            Probst
SELECT pro_id,(SELECT p.bezeichnung FROM Projekt p
				WHERE p.id =a.pro_id) bezeichnung,aufgabe ,(SELECT nachname FROM Mitarbeiter m
						WHERE a.mit_id =m.id) AS nachname
FROM Arbeit a
ORDER BY pro_id, aufgabe ASC;

-- Aufgabe 5.11
--
-- Geben Sie eine Liste aller Abteilngsnamen aus. Geben 
-- Sie dazu aus, wie viele Mitarbeiter in der Abteilung 
-- arbeiten. Nutzen Sie eine korrelierte Unterabfrage 
-- im SELECT.
--
--      bezeichnung  anzahl
--      Beratung     2
--      Diagnose     3
--      Freigabe     3
--      Einkauf      4
--      Verkauf      3
SELECT ab.bezeichnung, (SELECT COUNT(*) FROM Mitarbeiter m 
						WHERE ab.id=m.abt_id) AS anzahl
FROM Abteilung ab;


-- Aufgabe 5.12
--
-- Geben Sie eine Liste aller Mitarbeiter-Ids mit Gehalt aus.
-- Geben Sie dazu auch den Namen des Mitarbeiters aus. Nutzen
-- Sie eine korrelierte Unterabfrage im SELECT.
--
--      mit_id  nachname  gehalt
--      2581    Kaufmann  3000,00
--      5765    Schäfer   4500,00
--      9031    Meier     4000,00
--      9912    Wolf      3500,00
--      10102   Huber     3500,00
--      12121   Richter   3000,00
SELECT g.mit_id, (SELECT m.nachname FROM Mitarbeiter m
					WHERE m.id=g.mit_id) nachname, 
					g.gehalt
FROM Gehalt g;

-- Aufgabe 5.13
--
-- Erweitern Sie die Abfrage aus Aufgabe 5.12 und geben
-- Sie zusätzlich noch das Durschnitts-Gehalt aller 
-- Mitarbeiter aus. Zeigen Sie anschließend noch die
-- Differenz des Mitarbeiters zum Durchschnitt an.
--
--      mit_id  nachname  gehalt   durchschnitt  differenz
--      2581    Kaufmann  3000,00  3633,3333     -633,3333
--      5765    Schäfer   4500,00  3633,3333     866,6667
--      9031    Meier     4000,00  3633,3333     366,6667
--      9912    Wolf      3500,00  3633,3333     -133,3333
--      10102   Huber     3500,00  3633,3333     -133,3333
--      12121   Richter   3000,00  3633,3333     -633,3333
SELECT g.mit_id, (Select m.nachname FROM Mitarbeiter m
					WHERE m.id = g.mit_id ) nachname,
					g.gehalt,
					(SELECT AVG(gehalt) FROM Gehalt) durchschnitt,
					gehalt - (SELECT AVG(gehalt) FROM Gehalt) AS differenz
FROM Gehalt g;


-- Aufgabe 5.14
--
-- Zeigen Sie die Mitarbeiternamen und Abteilungsnamen der 
-- Mitarbeiter an, die im Projekt "Apollo" arbeiten. Nutzen 
-- Sie zwei verschachtelte Unterabfragen und eine korrelierte
-- Unterabfrage im SELECT.
--
--      nachname  abteilung
--      Meier     Diagnose
--      Huber     Freigabe
--      Krüger    Verkauf
--      Mozer     Beratung
--      Probst    Diagnose
SELECT m.nachname,(SELECT bezeichnung FROM Abteilung ab
					WHERE ab.id = m.abt_id) AS abtilung 
FROM Mitarbeiter m
WHERE m.id IN(SELECT mit_id FROM Arbeit 
			WHERE pro_id IN(SELECT id FROM Projekt
							WHERE bezeichnung ='Apollo'));
