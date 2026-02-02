/*
-------------------------------------------------------------------------------
Data Quality Checks
-------------------------------------------------------------------------------
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges.
    - Referential integrity between tables
-------------------------------------------------------------------------------
*/

-------------------------------------------------------------------------------
-- Checking 'core.vehicle_info'
-------------------------------------------------------------------------------

-- Check for NULLs or Duplicates in Primary Key
SELECT 
vehicle_id,
COUNT (*)
FROM core.vehicle_info
GROUP BY vehicle_id
HAVING COUNT (*) > 1 OR vehicle_id IS NULL;

SELECT 
accident_index
FROM core.vehicle_info
WHERE accident_index IS NULL;

-- Check for unwanted spaces in string fields
SELECT 
vehicle_id
FROM core.vehicle_info
WHERE vehicle_id != TRIM (vehicle_id);

SELECT 
accident_index
FROM core.vehicle_info
WHERE accident_index != TRIM (accident_index);

-- Data Standardization & Consistency
SELECT DISTINCT
left_hand
FROM core.vehicle_info;

-- Check for Negative Numbers in Vehicle Age
SELECT 
vehicle_age
FROM core.vehicle_info
WHERE vehicle_age < 0;

-------------------------------------------------------------------------------
-- Checking 'core.accident_info'
-------------------------------------------------------------------------------

-- Check for NULLs or Duplicates in Primary Key
SELECT 
accident_index,
COUNT (*)
FROM core.accident_info
GROUP BY accident_index
HAVING COUNT (*) > 1 OR accident_index IS NULL;

-- Check for unwanted spaces in string fields
SELECT 
accident_index
FROM core.accident_info
WHERE accident_index != TRIM (accident_index);

-- Data Standardization & Consistency
SELECT DISTINCT
area
FROM core.accident_info;

-- Invalid date ranges
SELECT 
accident_date
FROM core.accident_info
WHERE LEN (accident_date) != 10;

-- Future dates
SELECT accident_date
FROM core.accident_info
WHERE accident_date > GETDATE();

-- Check for Negative Numbers in Speed Limit
SELECT 
speed_limit
FROM core.accident_info
WHERE speed_limit < 0;

-- Accidents without vehicles
SELECT 
COUNT (*)
FROM core.accident_info AS a
LEFT JOIN core.vehicle_info AS v
ON a.accident_index = v.accident_index
WHERE v.accident_index IS NULL;

-- Vehicles without accidents
SELECT 
COUNT (*)
FROM core.vehicle_info AS v
LEFT JOIN core.accident_info AS a
ON v.accident_index = a.accident_index
WHERE a.accident_index IS NULL;
