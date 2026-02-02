/*
-------------------------------------------------------------------------------
DDL Script: Create 'vehicle_info' and 'accident_info' Tables
-------------------------------------------------------------------------------
Script Purpose:
    This script creates tables in the 'core' schema, dropping existing tables 
    if they already exist.
	Run this script to re-define the DDL structure of 'core' Tables
-------------------------------------------------------------------------------
*/

IF OBJECT_ID ('core.vehicle_info', 'U') IS NOT NULL
	DROP TABLE core.vehicle_info;
GO

CREATE TABLE core.vehicle_info (
	vehicle_id NVARCHAR (50), 
	accident_index NVARCHAR (50), 
	vehicle_type NVARCHAR (50), 
	point_impact NVARCHAR (50), 
	left_hand NVARCHAR (50), 
	journey_purpose NVARCHAR (50), 
	propulsion NVARCHAR (50), 
	vehicle_age INT
);
GO

IF OBJECT_ID ('core.accident_info', 'U') IS NOT NULL
	DROP TABLE core.accident_info;
GO

CREATE TABLE core.accident_info (
	accident_index NVARCHAR (50), 
	severity NVARCHAR (50), 
	accident_date DATE,
	accident_day NVARCHAR (50), 
	speed_limit INT,
	light_conditions NVARCHAR (50), 
	weather_conditions NVARCHAR (50), 
	road_conditions NVARCHAR (50), 
	area NVARCHAR (50)
);
GO
