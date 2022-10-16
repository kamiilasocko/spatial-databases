CREATE DATABASE firma; 
CREATE SCHEMA ksiegowosc;


SET search_path = ksiegowosc, "$user", public; -- For current session only

CREATE TABLE pracownicy (id_pracownika SERIAL NOT NULL, imie VARCHAR(50) NOT NULL, nazwisko VARCHAR(50) NOT NULL, adres VARCHAR(50) NOT NULL, telefon VARCHAR(50) NOT NULL);
CREATE TABLE godziny (id_godziny SERIAL NOT NULL, data DATE NOT NULL, liczba_godzin INT NOT NULL, id_pracownika INT NOT NULL);
CREATE TABLE pensja (id_pensji SERIAL NOT NULL, stanowisko VARCHAR(50) NOT NULL, kwota FLOAT(2) NOT NULL);
CREATE TABLE premia(id_premii SERIAL NOT NULL, rodzaj VARCHAR(50) NOT NULL, kwota FLOAT(2) NOT NULL);
CREATE TABLE wynagrodzenie(id_wynagrodzenia SERIAL NOT NULL, data DATE NOT NULL, id_pracownika INT NOT NULL, id_godziny INT NOT NULL, id_pensji INT NOT NULL, id_premii INT NOT NULL);

-- primary key
ALTER TABLE pracownicy ADD PRIMARY KEY (id_pracownika);
ALTER TABLE godziny ADD PRIMARY KEY (id_godziny);
ALTER TABLE pensja ADD PRIMARY KEY (id_pensji);
ALTER TABLE premia ADD PRIMARY KEY (id_premii);
ALTER TABLE wynagrodzenie ADD PRIMARY KEY (id_wynagrodzenia);
-- foreign key
ALTER TABLE godziny ADD FOREIGN KEY (id_pracownika) REFERENCES pracownicy(id_pracownika);
ALTER TABLE wynagrodzenie ADD FOREIGN KEY (id_pracownika) REFERENCES pracownicy(id_pracownika);
ALTER TABLE wynagrodzenie ADD FOREIGN KEY (id_godziny) REFERENCES godziny(id_godziny);
ALTER TABLE wynagrodzenie ADD FOREIGN KEY (id_pensji) REFERENCES pensja(id_pensji);
ALTER TABLE wynagrodzenie ADD FOREIGN KEY (id_premii) REFERENCES premia(id_premii);

-- comments
COMMENT ON TABLE pracownicy IS 'Informacje o pracownikach';
COMMENT ON TABLE godziny IS 'Informacje na temat godzin';
COMMENT ON TABLE pensja IS 'Informacje na temat pensji';
COMMENT ON TABLE premia IS 'Informacje o premiach';
COMMENT ON TABLE wynagrodzenie IS 'WYNAGRODZENIE';


-- insert values
INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES ('Ola', 'Nowak', 'Obozowa 34', '123444789');
INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES ('Wojtek', 'Nowak', 'Obozowa 34', '123456489');
INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES ('Jan', 'Bogusz', 'Krakow 10', '999666777');
INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES ('Ola', 'Bogusz', 'Helenow 45', '666666666');
INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES ('Aga', 'Jeren', 'Bydgoszcz 56', '123422289');
INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES ('Halina', 'Nowa', 'Krakow 45', '333444555');
INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES ('Adam', 'Smisz', 'Krakow 22', '444555666');
INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES ('Paul', 'Nowakowski', 'Warszawa 45', '777888555');
INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES ('Agnieszka', 'Kot', 'Krakow 12', '222555111');
INSERT INTO pracownicy (imie, nazwisko, adres, telefon) VALUES ('Piotr', 'Jar', 'Helenow 45', '555777333');

SELECT * FROM pracownicy;


INSERT INTO godziny (data, liczba_godzin , id_pracownika) VALUES ('2020-01-01', 12, 1);
INSERT INTO godziny (data, liczba_godzin , id_pracownika) VALUES ('2020-01-01', 8, 2);
INSERT INTO godziny (data, liczba_godzin , id_pracownika) VALUES ('2020-01-01', 2, 3);
INSERT INTO godziny (data, liczba_godzin , id_pracownika) VALUES ('2020-01-01', 10, 4);
INSERT INTO godziny (data, liczba_godzin , id_pracownika) VALUES ('2020-01-01', 11, 5);
INSERT INTO godziny (data, liczba_godzin , id_pracownika) VALUES ('2020-01-01', 6, 6);
INSERT INTO godziny (data, liczba_godzin , id_pracownika) VALUES ('2020-01-01', 8, 7);
INSERT INTO godziny (data, liczba_godzin , id_pracownika) VALUES ('2020-01-01', 8, 8);
INSERT INTO godziny (data, liczba_godzin , id_pracownika) VALUES ('2020-01-01', 5, 9);
INSERT INTO godziny (data, liczba_godzin , id_pracownika) VALUES ('2020-01-01', 9, 10);


SELECT * FROM godziny;

INSERT INTO premia (rodzaj, kwota) VALUES ('premia1', 50);
INSERT INTO premia (rodzaj, kwota) VALUES ('premia2', 1000);
INSERT INTO premia (rodzaj, kwota) VALUES ('premia3', 2000);
INSERT INTO premia (rodzaj, kwota) VALUES ('premia4', 5000);
INSERT INTO premia (rodzaj, kwota) VALUES ('premia5', 150);
INSERT INTO premia (rodzaj, kwota) VALUES ('premia6', 450);
INSERT INTO premia (rodzaj, kwota) VALUES ('premia7', 199);
INSERT INTO premia (rodzaj, kwota) VALUES ('premia8', 480);
INSERT INTO premia (rodzaj, kwota) VALUES ('premia9', 3000);
INSERT INTO premia (rodzaj, kwota) VALUES ('brak', 0);

SELECT * FROM premia;

INSERT INTO pensja (stanowisko,  kwota) VALUES ('skarbnik', 1000);
INSERT INTO pensja (stanowisko,  kwota) VALUES ('programista', 5000);
INSERT INTO pensja (stanowisko,  kwota) VALUES ('tester', 1500);
INSERT INTO pensja (stanowisko,  kwota) VALUES ('datascience', 8000);
INSERT INTO pensja (stanowisko,  kwota) VALUES ('ksiegowy', 1000);
INSERT INTO pensja (stanowisko,  kwota) VALUES ('prezes', 10000);
INSERT INTO pensja (stanowisko,  kwota) VALUES ('sprzataczka', 800);
INSERT INTO pensja (stanowisko,  kwota) VALUES ('analityk', 3000);
INSERT INTO pensja (stanowisko,  kwota) VALUES ('kucharz', 1200);
INSERT INTO pensja (stanowisko,  kwota) VALUES ('sekretarz', 5000);

SELECT * FROM pensja; 

INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('2020-01-01', 1, 1, 1, 1);
INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('2020-01-01', 2, 2, 1, 2);
INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('2020-01-01', 4, 3, 2, 3);
INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('2020-01-01', 5, 4, 6, 4);
INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('2020-01-01', 7, 5, 6, 1);
INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('2020-01-01', 10, 6, 1, 1);
INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('2020-01-01', 3, 7, 8, 1);
INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('2020-01-01', 8, 8, 1, 4);
INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('2020-01-01', 9, 9, 3, 10);
INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('2020-01-01', 6, 10, 10, 4);

SELECT * FROM wynagrodzenie;


-- a) 
SELECT id_pracownika, nazwisko from pracownicy;

-- b)
with cte1 as(
SELECT pracownicy.id_pracownika, pensja.kwota as pensja_kwota, premia.kwota as premia_kwota, pensja.kwota+premia.kwota as placa
FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji 
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii  
)
SELECT DISTINCT id_pracownika FROM cte1 
WHERE placa > 1000

-- bez premii w placy
SELECT pracownicy.id_pracownika FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji 
WHERE kwota > 1000;

-- c)

with cte1 as(
SELECT pracownicy.id_pracownika, pensja.kwota as pensja_kwota, premia.kwota as premia_kwota, pensja.kwota+premia.kwota as placa
FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji 
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii  
)

SELECT DISTINCT id_pracownika FROM cte1
WHERE premia_kwota = 0 and placa > 2000

-- bez premii w placy
SELECT pracownicy.id_pracownika FROM pracownicy
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii
WHERE pensja.kwota > 2000 AND premia.rodzaj = 'brak';


-- d)
SELECT * FROM pracownicy
WHERE imie LIKE 'J%'

-- e)
SELECT * FROM pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a'

-- f)
SELECT imie,nazwisko, liczba_godzin-160 AS nadgodziny, liczba_godzin FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN godziny ON wynagrodzenie.id_godziny = godziny.id_godziny 
WHERE liczba_godzin > 160;

-- g)
SELECT imie, nazwisko, kwota FROM pracownicy 
JOIN wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika 
JOIN pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
WHERE kwota BETWEEN 1500 AND 3000

-- h)
SELECT imie,nazwisko, liczba_godzin-160 AS nadgodziny, liczba_godzin FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN godziny ON wynagrodzenie.id_godziny = godziny.id_godziny 
JOIN premia ON premia.id_premii = wynagrodzenie.id_premii 
WHERE liczba_godzin > 160 AND rodzaj = 'brak'


-- i)
SELECT imie, nazwisko, kwota FROM pracownicy 
JOIN wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika 
JOIN pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
ORDER BY kwota

-- j)
SELECT imie, nazwisko, pensja.kwota AS pensja, premia.kwota AS premia FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii 
ORDER BY pensja.kwota DESC, premia.kwota DESC;

-- k)
SELECT count(pracownicy.id_pracownika), stanowisko FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
GROUP BY stanowisko

-- l)
WITH prezes as(
SELECT  imie, nazwisko, pensja.kwota AS pensja, premia.kwota AS premia, pensja.kwota+premia.kwota AS placa, stanowisko FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii 
WHERE stanowisko = 'prezes'
)
SELECT avg(placa) AS srednia_placa, min(placa) AS min_placa, max(placa) AS max_placa
FROM prezes

-- m)
WITH pracownicy_placa AS(
SELECT pracownicy.id_pracownika, pensja.kwota AS pensja, premia.kwota AS premia, pensja.kwota+premia.kwota AS placa FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii 
)
SELECT sum(placa) FROM pracownicy_placa


-- f)
WITH pracownicy_placa AS(
SELECT pracownicy.id_pracownika, pensja.kwota AS pensja, premia.kwota AS premia, pensja.kwota+premia.kwota AS placa, stanowisko FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii 
)
SELECT stanowisko, sum(placa) FROM pracownicy_placa
GROUP BY stanowisko

-- g)
WITH pracownicy_placa_premia AS(
SELECT pracownicy.id_pracownika, pensja.kwota AS pensja, premia.kwota AS premia, pensja.kwota+premia.kwota AS placa, stanowisko FROM pracownicy 
JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika 
JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN premia ON wynagrodzenie.id_premii = premia.id_premii 
WHERE premia.kwota != 0
)
SELECT stanowisko, count(premia) FROM pracownicy_placa_premia
GROUP BY stanowisko

-- h) 

ALTER TABLE pracownicy DISABLE TRIGGER ALL;
ALTER TABLE godziny DISABLE TRIGGER ALL;
ALTER TABLE wynagrodzenie DISABLE TRIGGER ALL;
ALTER TABLE pensja DISABLE TRIGGER ALL;
ALTER TABLE premia DISABLE TRIGGER ALL;

DELETE FROM pracownicy 
WHERE pracownicy.id_pracownika IN (SELECT pracownicy.id_pracownika FROM pracownicy 
									JOIN wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
									JOIN pensja ON wynagrodzenie.id_pensji = pensja.id_pensji 
									JOIN godziny ON godziny.id_pracownika = pracownicy.id_pracownika
									WHERE pensja.kwota < 1200);

DROP TABLE pracownicy, pensja, premia, wynagrodzenie, godziny CASCADE;
