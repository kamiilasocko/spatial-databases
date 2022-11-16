CREATE DATABASE cw4;

CREATE EXTENSION postgis;

-- 1
-- shp2pgsql C:\Users\Home\Desktop\qgis_sample_data\shapefiles\trees.shp trees | psql -U postgres -h localhost -p 5433 -d cw4
SELECT * FROM trees;
-- shp2pgsql C:\Users\Home\Desktop\qgis_sample_data\shapefiles\airports.shp airports | psql -U postgres -h localhost -p 5433 -d cw4
SELECT * FROM airports;
-- shp2pgsql C:\Users\Home\Desktop\qgis_sample_data\shapefiles\regions.shp regions | psql -U postgres -h localhost -p 5433 -d cw4
SELECT * FROM regions;
-- shp2pgsql C:\Users\Home\Desktop\qgis_sample_data\shapefiles\railroads.shp railroads | psql -U postgres -h localhost -p 5433 -d cw4
SELECT * FROM railroads;
-- shp2pgsql C:\Users\Home\Desktop\qgis_sample_data\shapefiles\popp.shp popp | psql -U postgres -h localhost -p 5433 -d cw4
SELECT * FROM popp;
-- shp2pgsql C:\Users\Home\Desktop\qgis_sample_data\shapefiles\rivers.shp rivers | psql -U postgres -h localhost -p 5433 -d cw4
SELECT * FROM rivers;
-- shp2pgsql C:\Users\Home\Desktop\qgis_sample_data\shapefiles\majrivers.shp majrivers | psql -U postgres -h localhost -p 5433 -d cw4
SELECT * FROM majrivers;
-- shp2pgsql C:\Users\Home\Desktop\qgis_sample_data\shapefiles\railroads_vertices.shp railroads_vertices | psql -U postgres -h localhost -p 5433 -d cw4
SELECT * FROM railroads_vertices;
-- shp2pgsql C:\Users\Home\Desktop\qgis_sample_data\shapefiles\swamp.shp swamp | psql -U postgres -h localhost -p 5433 -d cw4
SELECT * FROM swamp;
-- shp2pgsql C:\Users\Home\Desktop\qgis_sample_data\shapefiles\trails.shp trails | psql -U postgres -h localhost -p 5433 -d cw4
SELECT * FROM trails; 