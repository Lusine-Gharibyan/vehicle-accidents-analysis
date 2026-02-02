-- Vehicle Level Analysis

-- Which vehicle types are most frequently involved in accidents?
SELECT 
vehicle_type,
COUNT (accident_index) AS accident_count
FROM core.vehicle_info
GROUP BY vehicle_type
ORDER BY accident_count DESC;

-- What is the average vehicle age involved in accidents by vehicle type?
SELECT 
vehicle_type,
AVG (vehicle_age) AS avg_vehicle_age
FROM core.vehicle_info
WHERE vehicle_age IS NOT NULL
GROUP BY vehicle_type
ORDER BY avg_vehicle_age DESC;

-- Are work-related journeys more commonly involved in accidents than private journeys?
SELECT 
journey_purpose,
COUNT (accident_index) AS accident_count,
ROUND (COUNT (accident_index) / CAST (SUM (COUNT (accident_index)) OVER () AS FLOAT) * 100, 2) AS pct_of_total
FROM core.vehicle_info
GROUP BY journey_purpose
ORDER BY accident_count DESC;

-- What propulsion types (petrol, diesel, etc.) are most common in accidents?
SELECT 
propulsion,
COUNT (accident_index) AS accident_count,
ROUND (COUNT (accident_index) / CAST (SUM (COUNT (accident_index)) OVER () AS FLOAT) * 100, 2) AS pct_of_total
FROM core.vehicle_info
GROUP BY propulsion
ORDER BY accident_count DESC;

-- Which point of impact is most frequent for different vehicle types?
SELECT 
vehicle_type,
point_impact,
COUNT (accident_index) AS accident_count,
ROUND (COUNT (accident_index) / CAST (SUM (COUNT (accident_index)) OVER (PARTITION BY vehicle_type) AS FLOAT) * 100, 2) AS pct_within_vehicle_type
FROM core.vehicle_info
GROUP BY vehicle_type, point_impact
ORDER BY vehicle_type, accident_count DESC;
