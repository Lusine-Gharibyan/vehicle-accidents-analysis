/*
---------------------------------------------------------------------------------------
Stored Procedure: Load Data
---------------------------------------------------------------------------------------
Script Purpose:
    This stored procedure loads data into the 'core' schema from external CSV files. 
    It performs the following actions:
    - Truncates the 'core' tables before loading data.
    - Uses the `BULK INSERT` command to load data from CSV Files to 'core' tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC core.load_tables;
---------------------------------------------------------------------------------------
*/

CREATE OR ALTER PROCEDURE core.load_tables AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		SET @start_time = GETDATE();
		TRUNCATE TABLE core.vehicle_info;
		PRINT 'Inserting data into: core.vehicle_info';
		BULK INSERT core.vehicle_info
		FROM 'C:\Users\user\Desktop\sql project datasets\vehicle accident\vehicle_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		TRUNCATE TABLE core.accident_info;
		PRINT 'Inserting data into: core.accident_info';
		BULK INSERT core.accident_info
		FROM 'C:\Users\user\Desktop\sql project datasets\vehicle accident\accident_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Total Load Duration: ' + CAST (DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	END TRY
	BEGIN CATCH
		PRINT 'ERROR OCCURED DURING LOADING';
		PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
	END CATCH
END
