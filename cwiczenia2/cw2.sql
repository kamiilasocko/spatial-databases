CREATE DATABASE cw2;

CREATE EXTENSION postgis;

-- ADDITIONAL INFORMATION
-- wkt - well-known text FOR representing vector geometries
-- for polygon first and last coordinates is the same

-- 4
CREATE TABLE buildings (id INTEGER PRIMARY KEY, geometry GEOMETRY, name VARCHAR);
CREATE TABLE roads (id INTEGER PRIMARY KEY, geometry GEOMETRY, name VARCHAR);
CREATE TABLE poi (id INTEGER PRIMARY KEY, geometry GEOMETRY, name VARCHAR);

-- 5
INSERT INTO buildings(id, geometry, name) VALUES 
	(1, ST_GeomFromText('POLYGON ((8 1.5, 10.5 1.5, 10.5 4, 8 4, 8 1.5))', 0), 'BuildingA'),
	(2, ST_GeomFromText('POLYGON ((4 5, 6 5, 6 7, 4 7, 4 5))', 0), 'BuildingB'),
	(3, ST_GeomFromText('POLYGON ((3 6, 5 6, 5 8, 3 8, 3 6))', 0), 'BuildingC'),
	(4, ST_GeomFromText('POLYGON ((9 8, 10 8, 10 9, 9 9, 9 8))', 0), 'BuildingD'),
	(5, ST_GeomFromText('POLYGON ((1 1, 2 1, 2 2, 1 2, 1 1))', 0), 'BuildingF');

SELECT * FROM buildings 

INSERT INTO roads(id, geometry, name) VALUES 
	(1, ST_GeomFromText('LINESTRING (0 4.5, 12 4.5)', 0),'RoadX'),
	(2, ST_GeomFromText('LINESTRING (7.5 0, 7.5 10.5)', 0),'RoadY');

SELECT * FROM roads

INSERT INTO poi(id, geometry, name) VALUES
	(1, ST_GeomFromText('POINT(1 3.5)', 0), 'G'),
	(2, ST_GeomFromText('POINT(5.5 1.5)', 0), 'H'),
	(3, ST_GeomFromText('POINT(9.5 6)', 0), 'I'),
	(4, ST_GeomFromText('POINT(6.5 6)', 0), 'J'),
	(5, ST_GeomFromText('POINT(6 9.5)', 0), 'K');

SELECT * FROM poi
	
-- 6a
SELECT name, ST_Length(geometry) FROM roads 

SELECT SUM(ST_Length(geometry)) FROM roads

-- 6b
SELECT st_astext(geometry), st_area(geometry), st_perimeter(geometry) 
FROM buildings 
WHERE name = 'BuildingA' -- st_astext is mainly FOR BINARY notation 

-- 6c
SELECT name, st_area(geometry)
FROM buildings
ORDER BY name ASC 

-- 6d 
SELECT name, st_perimeter(geometry)
FROM buildings 
ORDER BY st_area(geometry) desc
LIMIT 2

-- 6e
SELECT min(st_distance(b.geometry, p.geometry)) FROM buildings b 
CROSS JOIN poi p
WHERE b.name = 'BuildingC' AND p.name = 'K'


SELECT MIN(ST_Distance(buildings.geometry, poi.geometry))
FROM buildings, poi
WHERE buildings.name = 'BuildingC' AND poi.name = 'K'

-- 6f
-- st_buffer - buffer in specific size
-- st_intersection - returns a geometry representing the point-set intersection of two geometries. In other words, that portion of geometry A and geometry B that is shared between the two geometries.
-- st_difference - returns a geometry representing the part of geometry A that does not intersect geometry B

SELECT ST_Area(st_difference((SELECT geometry
								FROM buildings 
								WHERE name = 'BuildingC'),
								ST_Buffer((SELECT geometry 
											FROM buildings 
											WHERE name='BuildingB'), 0.5)));
-- 6g
SELECT buildings.name, ST_Centroid(buildings.geometry)
FROM buildings, roads
WHERE ST_Y(ST_Centroid(buildings.geometry)) > ST_Y(ST_Centroid(roads.geometry)) 
AND roads.name = 'RoadX';

-- 8
-- st_symdifference - Returns a geometry representing the portions of geonetries A and B that do not intersect. 
SELECT st_area(st_symdifference((SELECT geometry 
									FROM buildings 
									WHERE name = 'BuildingC'),  
									ST_GeomFromText('POLYGON ( (4 7, 6 7, 6 8, 4 8, 4 7))')))

