SELECT * FROM arel_dataset.attendance;


-- 03_attendence_ by_ month.sql
-- Quastion;
-- does attendence as the course progress

SELECT
	DATE_FORMAT(session_date,'%Y-%m') AS month,
    ROUND(
		100 * SUM(status IN ('present', 'late')) / COUNT(*),
        1
        ) AS attendence_rate,
        
        COUNT(*) AS total_sessions
        
FROM attendance
WHERE status <> 'Not Recorded'
GROUP BY month;
    
-- Result
-- 
--
--

    
    
    
    
    
    
    
    
    
    
    
    
    