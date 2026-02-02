/*
----------------------------------------------------------------------------------------------------
Create Database and Schema
----------------------------------------------------------------------------------------------------
Script Purpose:
    This script creates a new database named 'VehicleAccident' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up 'core' 
    schema within the database.
	
WARNING:
    Running this script will drop the entire 'VehicleAccident' database if it exists. 
    All data in the database will be permanently deleted.
----------------------------------------------------------------------------------------------------
*/

USE MASTER;
GO

-- Drop and recreate the 'VehicleAccident' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'VehicleAccident')
BEGIN
	ALTER DATABASE VehicleAccident SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE VehicleAccident;
END;
GO

-- Create the 'VehicleAccident' database
CREATE DATABASE VehicleAccident;
GO

USE VehicleAccident;
GO

-- Create Schema
CREATE SCHEMA core;
GO
