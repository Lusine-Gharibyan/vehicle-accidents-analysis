-- Accident Level Analysis

-- How do traffic accidents trend over time (by month)?
SELECT 
DATETRUNC (MONTH, accident_date) AS accident_date,
COUNT (accident_index) AS accident_count
FROM core.accident_info
GROUP BY DATETRUNC (MONTH, accident_date)
ORDER BY accident_date;

-- What proportion of accidents are Slight vs Serious vs Fatal?
SELECT 
severity,
COUNT (accident_index) AS accident_count,
ROUND (COUNT (accident_index) / CAST (SUM (COUNT (accident_index)) OVER () AS FLOAT) * 100, 2) AS pct_of_total
FROM core.accident_info
GROUP BY severity
ORDER BY accident_count DESC;

-- Do accidents occur more frequently in Urban or Rural areas?
SELECT 
area,
COUNT (accident_index) AS accident_count,
ROUND (COUNT (accident_index) / CAST (SUM (COUNT (accident_index)) OVER () AS FLOAT) * 100, 2) AS pct_of_total
FROM core.accident_info
GROUP BY area
ORDER BY accident_count DESC;

-- How does speed limit relate to accident severity?
SELECT 
speed_limit,
severity,
COUNT (accident_index) AS accident_count,
ROUND (COUNT (accident_index) / CAST (SUM (COUNT (accident_index)) OVER (PARTITION BY speed_limit) AS FLOAT) * 100, 2) AS pct_of_total
FROM core.accident_info
GROUP BY speed_limit, severity
ORDER BY speed_limit, accident_count DESC;

-- What road conditions are most commonly associated with accidents?
SELECT 
road_conditions,
COUNT (accident_index) AS accident_count,
ROUND (COUNT (accident_index) / CAST (SUM (COUNT (accident_index)) OVER () AS FLOAT) * 100, 2) AS pct_of_total
FROM core.accident_info
GROUP BY road_conditions
ORDER BY accident_count DESC;

-- Does weather condition impact accident severity?
SELECT 
weather_conditions,
severity,
COUNT (accident_index) AS accident_count,
ROUND (COUNT (accident_index) / CAST (SUM (COUNT (accident_index)) OVER (PARTITION BY weather_conditions) AS FLOAT) * 100, 2) AS pct_of_total
FROM core.accident_info
GROUP BY weather_conditions, severity
ORDER BY weather_conditions, accident_count DESC;

-- Are accidents more frequent during daylight or darkness?
SELECT 
light_conditions,
COUNT (accident_index) AS accident_count,
ROUND (COUNT (accident_index) / CAST (SUM (COUNT (accident_index)) OVER () AS FLOAT) * 100, 2) AS pct_of_total
FROM core.accident_info
GROUP BY light_conditions
ORDER BY accident_count DESC;
