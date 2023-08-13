USE KAMIL;

DROP TABLE IF EXISTS Tablica1;
DROP TABLE IF EXISTS Tablica2;

CREATE TABLE Tablica1 (
    Numer INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Nazwisko VARCHAR(24),
	Imie VARCHAR(24),
	Wiek INT,
	P_id INT
);

CREATE TABLE Tablica2 (
	P_id INT NOT NULL PRIMARY KEY,
	Opis VARCHAR(24)
);

INSERT INTO Tablica1 (Nazwisko, Imie, Wiek, P_id) VALUES ('Anio³', 'Stanis³aw', 55, 1);
INSERT INTO Tablica1 (Nazwisko, Imie, Wiek, P_id) VALUES ('Winnicki', 'Jan', 45, 1);
INSERT INTO Tablica1 (Nazwisko, Imie, Wiek, P_id) VALUES ('Wagner', 'Tekla', 65, 2);
INSERT INTO Tablica1 (Nazwisko, Imie, Wiek, P_id) VALUES ('Cichocki', 'Dionizy', 65, 3);
INSERT INTO Tablica1 (Nazwisko, Imie, Wiek, P_id) VALUES ('Majewska', NULL, 36, 2);

INSERT INTO Tablica2 (P_id, Opis) VALUES (1, 'Mê¿czyzna');
INSERT INTO Tablica2 (P_id, Opis) VALUES (2, 'Kobieta');

--SELECT * FROM Tablica1;
--SELECT * FROM Tablica2;

--ZADANIE 3
--SELECT * FROM Tablica1 WHERE Imie LIKE '%s³aw' AND wiek > 40;

--ZADANIE 4
--SELECT Opis, COUNT(Tablica1.P_id) AS Ile_osób, SUM(Tablica1.Wiek) AS Suma_wiek FROM Tablica1 LEFT JOIN Tablica2 ON Tablica1.P_id = Tablica2.P_id GROUP BY Opis;

--ZADANIE 5
--SELECT Wiek, COUNT(P_id) as Ile FROM Tablica1 GROUP BY Wiek HAVING COUNT(P_id)>1;

--ZADANIE 6
--SELECT * FROM Tablica1 WHERE Imie is NULL;

--ZADANIE 7
--SELECT * FROM Tablica1 WHERE Wiek = (SELECT MIN(Wiek) FROM Tablica1);

--ZADANIE 8
DECLARE @P_id INT = (SELECT Tablica1.P_id FROM Tablica1 LEFT JOIN Tablica2 ON Tablica1.P_id = Tablica2.P_id WHERE Tablica2.P_id is NULL GROUP BY Tablica1.P_id);
--INSERT INTO Tablica2 (P_id, Opis) VALUES (@P_id, NULL);
--SELECT * FROM Tablica2;

--ZADANIE 9
--DELETE FROM Tablica1 WHERE P_id = @P_id;
--SELECT * FROM Tablica1;



DROP TABLE IF EXISTS Zakupy;
DROP TABLE IF EXISTS Kontrhenci;

CREATE TABLE Zakupy (
    ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Id_klienta INT NOT NULL,
	Towar VARCHAR(24),
	Wartosc_zakupu INT,
	Data_zakupu DATE
);

CREATE TABLE Kontrhenci (
	ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Nazwisko VARCHAR(24)
);

INSERT INTO Zakupy (Id_klienta, Towar, Wartosc_zakupu, Data_zakupu) VALUES (2,'wiertarka', 600, '2012-12-05');
INSERT INTO Zakupy (Id_klienta, Towar, Wartosc_zakupu, Data_zakupu) VALUES (4,'imad³o', 150, '2013-01-04');
INSERT INTO Zakupy (Id_klienta, Towar, Wartosc_zakupu, Data_zakupu) VALUES (1,'pi³a', 350, '2013-02-10');
INSERT INTO Zakupy (Id_klienta, Towar, Wartosc_zakupu, Data_zakupu) VALUES (1,'kosiarka', 400, '2013-02-12');
INSERT INTO Zakupy (Id_klienta, Towar, Wartosc_zakupu, Data_zakupu) VALUES (1,'siekiera', 60, '2013-03-15');

INSERT INTO Kontrhenci (Nazwisko) VALUES ('Kowalski');
INSERT INTO Kontrhenci (Nazwisko) VALUES ('Kura');
INSERT INTO Kontrhenci (Nazwisko) VALUES ('Iksiñski');
INSERT INTO Kontrhenci (Nazwisko) VALUES ('Robakowska');
INSERT INTO Kontrhenci (Nazwisko) VALUES ('Adamczyk');

--SELECT * FROM Zakupy;
--SELECT * FROM Kontrhenci;

--ZADANIE A
--SELECT Kontrhenci.Nazwisko FROM Kontrhenci LEFT JOIN Zakupy ON Kontrhenci.ID = Zakupy.Id_klienta WHERE Zakupy.Id_klienta is NULL;

--ZADANIE B
--SELECT SUM(Zakupy.Wartosc_zakupu), Kontrhenci.Nazwisko FROM Zakupy INNER JOIN Kontrhenci ON Kontrhenci.ID = Zakupy.Id_klienta GROUP BY Kontrhenci.Nazwisko;

--ZADANIE C
--SELECT Kontrhenci.Nazwisko FROM Zakupy INNER JOIN Kontrhenci ON Kontrhenci.ID = Zakupy.Id_klienta GROUP BY Kontrhenci.Nazwisko HAVING SUM(Zakupy.Wartosc_zakupu)<200;