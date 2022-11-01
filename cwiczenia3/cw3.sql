CREATE DATABASE cw3;

CREATE EXTENSION postgis;

-- 1
-- shp2pgsql C:\Users\Home\Desktop\T2018_KAR_GERMANY\T2018_KAR_BUILDINGS.shp t2018_kar_buildings | psql -U postgres -h localhost -p 5433 -d cw3

-- shp2pgsql C:\Users\Home\Desktop\T2019_KAR_GERMANY\T2019_KAR_BUILDINGS.shp t2019_kar_buildings | psql -U postgres -h localhost -p 5433 -d cw3


SELECT * FROM t2018_kar_buildings;
SELECT * FROM t2019_kar_buildings;

-- 1
CREATE VIEW new_b AS
SELECT b2019.gid, b2019.polygon_id, b2019.name, b2019.type, b2019.height, b2019.geom
FROM t2019_kar_buildings b2019
LEFT JOIN t2018_kar_buildings b2018 ON b2018.geom = b2019.geom
WHERE b2018.gid IS NULL;

SELECT * FROM new_b


-- 2

-- shp2pgsql C:\Users\Home\Desktop\T2018_KAR_GERMANY\T2018_KAR_POI_TABLE.shp t2018_kar_poi | psql -U postgres -h localhost -p 5433 -d cw3
-- shp2pgsql C:\Users\Home\Desktop\T2019_KAR_GERMANY\T2019_KAR_POI_TABLE.shp t2019_kar_poi | psql -U postgres -h localhost -p 5433 -d cw3

SELECT * FROM t2018_kar_poi;
SELECT * FROM t2019_kar_poi;



CREATE VIEW new_p AS
SELECT poi2019.gid, poi2019.poi_id, poi2019.link_id, poi2019.type, poi2019.poi_name, poi2019.st_name, poi2019.lat, poi2019.lon,poi2019.geom
FROM t2019_kar_poi poi2019
LEFT JOIN t2018_kar_poi poi2018 ON poi2018.geom = poi2019.geom
WHERE poi2018.gid IS NULL; 

SELECT * FROM new_p;


SELECT new_p.type, count(new_p.type)
FROM new_b, new_p
WHERE ST_Contains(ST_Buffer(new_b.geom,0.005), new_p.geom)
GROUP BY new_p.TYPE

-- 3



-- shp2pgsql C:\Users\Home\Desktop\T2019_KAR_GERMANY\T2019_KAR_STREETS.shp streets2019 | psql -U postgres -h localhost -p 5433 -d cw3
SELECT * FROM streets2019 s 


CREATE TABLE streets_reprojected (
	gid SERIAL NOT NULL,
	link_id numeric NULL,
	st_name varchar(254) NULL,
	ref_in_id numeric NULL,
	nref_in_id numeric NULL,
	func_class varchar(1) NULL,
	speed_cat varchar(1) NULL,
	fr_speed_l numeric NULL,
	to_speed_l numeric NULL,
	dir_travel varchar(1) NULL,
	geom geometry NULL
);


INSERT INTO streets_reprojected 
SELECT gid, link_id, st_name, ref_in_id, nref_in_id, func_class, speed_cat, fr_speed_l, to_speed_l,
		dir_travel, ST_Transform(ST_SetSRID(geom,4326), 3068)
FROM streets2019 


SELECT * FROM streets_reprojected;


-- 4

CREATE TABLE inputs_points (id int, name varchar, geom geometry);

INSERT INTO inputs_points VALUES
   (1, 'point1', 'POINT(8.36093 49.03174)'),
   (2, 'point2', 'POINT(8.39876 49.00644)');
  
  
SELECT * FROM inputs_points;
  
  
  -- 5
  
UPDATE inputs_points 
SET geom = ST_Transform(st_setsrid(geom,4326), 3068);

  
SELECT * FROM inputs_points;
 
-- 6
-- shp2pgsql C:\Users\Home\Desktop\T2019_KAR_GERMANY\T2019_KAR_STREET_NODE.shp street_node | psql -U postgres -h localhost -p 5433 -d cw3
SELECT * FROM street_node sn;

UPDATE street_node  
SET geom = ST_Transform(st_setsrid(geom,4326), 3068);
 
 
CREATE VIEW line_points AS
SELECT st_makeline(geom) AS geom
FROM inputs_points;
  
SELECT * FROM line_points ;


SELECT DISTINCT node_id
FROM line_points l, street_node n
WHERE ST_Contains(ST_Buffer(l.geom, 0.002),n.geom)

-- 7
-- shp2pgsql C:\Users\Home\Desktop\T2019_KAR_GERMANY\T2019_KAR_LAND_USE_A.shp land_usa2019 | psql -U postgres -h localhost -p 5433 -d cw3



CREATE VIEW sporting_store AS
SELECT * FROM t2019_kar_poi poi 
WHERE poi."type" = 'Sporting Goods Store'


CREATE VIEW new_parks AS
SELECT * FROM land_usa2019 lu 
WHERE lu."type" = 'Park (City/County)'
 
SELECT * FROM new_parks 


SELECT count(*) 
FROM new_parks, sporting_store
WHERE ST_Contains(St_Buffer(new_parks.geom,0.003),sporting_store.geom)



-- 8 
-- shp2pgsql C:\Users\Home\Desktop\T2019_KAR_GERMANY\T2019_KAR_RAILWAYS.shp railways2019 | psql -U postgres -h localhost -p 5433 -d cw3
-- shp2pgsql C:\Users\Home\Desktop\T2019_KAR_GERMANY\T2019_KAR_WATER_LINES.shp waterlines2019 | psql -U postgres -h localhost -p 5433 -d cw3
SELECT * FROM waterlines2019;
SELECT * FROM railways2019;


select st_intersection(w.geom, r.geom) 
INTO T2019_KAR_BRIDGES
FROM waterlines2019  w, railways2019 r
where st_intersects(w.geom, r.geom) = true;

SELECT * FROM t2019_KAR_BRIDGES