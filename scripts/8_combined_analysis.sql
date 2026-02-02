-- Combined Analysis

-- How does accident severity vary by vehicle type?
SELECT 
v.vehicle_type,
a.severity,
COUNT (a.accident_index) AS accident_count,
ROUND (COUNT (a.accident_index) / CAST (SUM (COUNT (a.accident_index)) OVER (PARTITION BY v.vehicle_type) AS FLOAT) * 100, 2) AS pct_of_total
FROM core.vehicle_info AS v
LEFT JOIN core.accident_info AS a
ON v.accident_index = a.accident_index
GROUP BY v.vehicle_type, a.severity
ORDER BY v.vehicle_type, accident_count DESC;

-- Which vehice age groups contribute most to each severity level
WITH cte AS (
	SELECT 
	CASE WHEN vehicle_age BETWEEN 0 AND 4 THEN 'New'
		 WHEN vehicle_age BETWEEN 5 AND 10 THEN 'Regular'
		 ELSE 'Old'
	END vehicle_age_group,
	a.severity AS severity,
	a.accident_index AS accident_index
	FROM core.vehicle_info AS v
	LEFT JOIN core.accident_info AS a
	ON v.accident_index = a.accident_index
)
SELECT 
severity,
vehicle_age_group,
COUNT (accident_index) AS accident_count,
ROUND (COUNT (accident_index) / CAST (SUM (COUNT (accident_index)) OVER (PARTITION BY severity) AS FLOAT) * 100, 2) AS pct_of_total
FROM cte
GROUP BY vehicle_age_group, severity
ORDER BY severity, accident_count DESC;

-- Do certain vehicle types have higher involvement in urban vs rural accidents?
SELECT 
a.area,
v.vehicle_type,
COUNT (a.accident_index) AS accident_count,
ROUND (COUNT (a.accident_index) / CAST (SUM (COUNT (a.accident_index)) OVER (PARTITION BY a.area) AS FLOAT) * 100, 2) AS pct_of_total
FROM core.vehicle_info AS v
LEFT JOIN core.accident_info AS a
ON v.accident_index = a.accident_index
GROUP BY a.area, v.vehicle_type
ORDER BY a.area, accident_count DESC;

-- How does point of impact influence accident severity
SELECT
v.point_impact,
a.severity,
COUNT (a.accident_index) AS accident_count,
ROUND (COUNT (a.accident_index) / CAST (SUM (COUNT (a.accident_index)) OVER (PARTITION BY v.point_impact) AS FLOAT) * 100, 2) AS pct_of_total
FROM core.vehicle_info AS v
LEFT JOIN core.accident_info AS a
ON v.accident_index = a.accident_index
GROUP BY v.point_impact, a.severity
ORDER BY v.point_impact, accident_count DESC;
