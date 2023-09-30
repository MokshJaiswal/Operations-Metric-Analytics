# Case Study 2
USE project3;

CREATE TABLE email_events(
user_id INT,
occured_at VARCHAR(100),
action VARCHAR(100),
user_type INT
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM email_events;

ALTER TABLE email_events ADD COLUMN temp_occured_at DATETIME AFTER user_id;

SET SQL_SAFE_UPDATES = 0;

UPDATE email_events SET temp_occured_at = STR_TO_DATE(occured_at, '%d-%m-%Y %H:%i');

ALTER TABLE email_events DROP occured_at;

ALTER TABLE email_events CHANGE COLUMN temp_occured_at occured_at DATETIME; 

SELECT * FROM email_events;
SELECT * FROM users;
SELECT * FROM events;


# A. Weekly user engagement
SELECT EXTRACT(WEEK FROM occured_at) AS Week_Num, COUNT(user_id) AS Active_Users
FROM events
WHERE event_type = 'engagement'
AND event_name = 'login'
GROUP BY Week_Num;

# B. Write an SQL query to calculate the user growth for the product.
SELECT EXTRACT(MONTH FROM created_at) AS month,
COUNT(user_id) AS user_count,
LEAD(COUNT(user_id),1) OVER(ORDER BY MIN(created_at)) AS next_month_users
FROM users
GROUP BY month;


#SELECT Week_No, Year, All_active_users,
#	SUM(All_active_users) OVER(ORDER BY Year, Week_No) AS Cum_active_users
#FROM(
#	SELECT EXTRACT(WEEK FROM activated_at) AS Week_No, 
#		   EXTRACT(YEAR FROM activated_at) AS Year, 
#		   COUNT(DISTINCT user_id) AS All_active_users
#	FROM users
#	GROUP BY Week_No,Year
 #   ) AS Temp;

# C. Weekly Retention Analysis
WITH cohort AS(
	SELECT user_id, MIN(occured_at) AS signup_date
	FROM events
    WHERE event_type = 'engagement' AND event_name = 'login'
    GROUP BY user_id
),
user_week AS(
	SELECT e.user_id, 
    EXTRACT(WEEK FROM occured_at) AS event_week,
    EXTRACT(WEEK FROM signup_date) AS signup_week
    FROM events e
JOIN cohort c
ON e.user_id = c.user_id
),
weekly_cohort AS(
	SELECT event_week, signup_week, COUNT(DISTINCT(uw.user_id)) AS cohort_size
    FROM user_week uw
    WHERE event_week <= signup_week + 7
    GROUP BY event_week, signup_week
)
SELECT wc.signup_week, wc.event_week, wc.cohort_size,
	SUM(CASE WHEN wc.event_week - wc.signup_week <= 7 THEN 1 ELSE 0 END) AS retention_count,
    ROUND(SUM(CASE WHEN wc.event_week - wc.signup_week <= 7 THEN 1 ELSE 0 END) / wc.cohort_size * 100, 2) AS retention_rate
FROM weekly_cohort wc
GROUP BY wc.signup_week, wc.event_week, wc.cohort_size
ORDER BY wc.signup_week, wc.event_week;

	
# D. Weekly Engagement Per Device
SELECT COUNT(DISTINCT user_id) AS num_users, EXTRACT(WEEK FROM occured_at) AS week, device
FROM events
WHERE event_type = 'engagement'
GROUP BY week,device
ORDER BY week,device;
 
# E. Email Engagement Analysis:
SELECT distinct action FROM email_events; #sent_weekly_digest, email_open, email_clickthrough, sent_reengagement_email

SELECT 100 * SUM(CASE WHEN email_cat = 'email_open' THEN 1 ELSE 0 END)/SUM(CASE WHEN email_cat = 'email_sent' THEN 1 ELSE 0 END) AS email_opened_rate,
	   100 * SUM(CASE WHEN email_cat = 'email_clickthrough' THEN 1 ELSE 0 END)/SUM(CASE WHEN email_cat = 'email_sent' THEN 1 ELSE 0 END) AS email_clicked_rate
FROM
	(SELECT *, 
	CASE 
		WHEN action IN ('sent_weekly_digest','sent_reengagement_email')
		THEN 'email_sent'
		WHEN action IN ('email_open')
		THEN 'email_open'
		WHEN action IN ('email_clickthrough')
		THEN 'email_clicked'
		END AS email_cat
	FROM email_events
	) AS cte;


SELECT * FROM EVENTS;
SELECT * FROM EMAIL_EVENTS