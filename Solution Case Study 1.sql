# Case Study 1
SELECT * FROM job_data;

#A.	Jobs Reviewed Over Time:
SELECT ds, COUNT(*) AS jobs_reviewed_per_day, SUM(time_spent)/3600 AS hours_spent_reviewing
FROM job_data
group by ds;

# B. Throughput Analysis: Using two different types of subqueries
# type 1.
SELECT ds, ROUND(SUM(num_event) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) / 
				SUM(total_time) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS rolling_7D_average
FROM ( 
	SELECT ds, COUNT(*) AS num_event , SUM(time_spent) AS total_time 
	FROM job_data
	GROUP BY ds) AS totals;

# type 2.
WITH CTE AS (
  SELECT 
    ds, 
    COUNT(*) AS num_events,
    SUM(time_spent) AS total_time
  FROM job_data
  GROUP BY ds
)
SELECT 
  ds, 
  ROUND(SUM(num_events) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) / 
		SUM(total_time) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2
  ) AS rolling_avg
FROM CTE;

# C. Language Share Analysis.
SELECT language, ROUND(100*COUNT(*)/(SELECT COUNT(*) FROM job_data),2) AS Percentage
FROM job_data
WHERE ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY language;

# Duplicate Rows Detection: Using 2 different ways
SET SQL_SAFE_UPDATES = 0;
# Method 1.
WITH Duplicates AS(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY job_id) AS RowNumber
	FROM job_data
)
SELECT * FROM Duplicates 
WHERE RowNumber NOT IN 
(SELECT MIN(RowNumber) FROM DUPLICATES GROUP BY job_id);

# Method 2.
WITH Duplicates AS(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY job_id) AS RowNumber
	FROM job_data
)
SELECT * FROM Duplicates 
WHERE RowNumber > 1;