CREATE DATABASE cw5;

CREATE EXTENSION postgis;


-- zadanie 1
CREATE TABLE obiekty(id int, geometry geometry, name varchar);



INSERT INTO obiekty VALUES (1, ST_COLLECT(array[ST_GeomFromText('LINESTRING(0 1, 1 1)'),
												ST_GeomFromText('CIRCULARSTRING(1 1, 2 0, 3 1)'),
												ST_GeomFromText('CIRCULARSTRING(3 1, 4 2, 5 1)'),
												ST_GeomFromText('LINESTRING(5 1, 6 1)')]), 'obiekt1'); 											
INSERT INTO obiekty VALUES (2, ST_COLLECT(array[ST_GeomFromText('LINESTRING(10 6, 14 6)'),
												ST_GeomFromText('CIRCULARSTRING(14 6, 16 4, 14 2)'),
												ST_GeomFromText('CIRCULARSTRING(14 2, 12 0, 10 2)'),
												ST_GeomFromText('LINESTRING(10 2, 10 6)'),
												ST_GeomFromText('CIRCULARSTRING(11 2, 12 2, 11 2)')]), 'obiekt2');																							
INSERT INTO obiekty VALUES (3, ST_MakePolygon( ST_GeomFromText('LINESTRING(7 15, 10 17, 12 13, 7 15)')), 'obiekt3'); 
INSERT INTO obiekty VALUES (4, ST_LineFromMultiPoint('MULTIPOINT(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)'), 'obiekt4');
INSERT INTO obiekty VALUES (5, 'MULTIPOINT(30 30 59,38 32 234)', 'obiekt5');
INSERT INTO obiekty VALUES (6, ST_COLLECT(array[ST_GeomFromText('LINESTRING(1 1, 3 2)'),
												ST_GeomFromText('POINT(4 2)')]), 'obiekt6');																				
SELECT * FROM obiekty;

-- zadanie 2
SELECT st_area(st_buffer(st_shortestline((SELECT geometry FROM obiekty WHERE name='obiekt3'), (SELECT geometry FROM obiekty WHERE name='obiekt4')),5));

-- zadanie 3
-- Ostatnia wspolrzedna w poligonie musi byc taka sama jak pierwsza.
UPDATE obiekty 
SET geometry = ST_MakePolygon(ST_AddPoint(geometry, 'POINT(20 20)')) WHERE name = 'obiekt4';

-- zadanie 4
INSERT INTO obiekty VALUES (7, ST_Collect((SELECT geometry FROM obiekty WHERE name = 'obiekt3'), (SELECT geometry FROM obiekty WHERE name = 'obiekt4')),'obiekt7');
-- zadanie 5
SELECT name, st_area(st_buffer(geometry,5))FROM obiekty 
WHERE St_hasArc(geometry) = FALSE 

