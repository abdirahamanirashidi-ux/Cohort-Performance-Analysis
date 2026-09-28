-- 05_schedule_Comperison.sql
--
-- Quetion
-- Does the number of trainning days per week affect attendance
--
-- Cohort 2 to 5 used a three- day   week (MWF), While Cohort 6
-- Used a five-day week MTWTF)


SELECT
	c.schedule,
    ROUND(100 * SUM(a.status IN ('present', 'late')) / COUNT(*)
    ) AS attendance_rate,
    COUNT(*) AS n
    
    FROM attendance a
    JOIN enrolments e ON a.enrolment_id = e.enrolment_id
    JOIN cohorts c ON e.cohort_id = c.cohort_id
    
    WHERE a.status <> 'Not Recorded'
    GROUP BY c.schedule;
    
    -- Result
    -- Attendance is almost the same under both schedules
    -- 55% for the five day week and 55.9% for the three day week
    -- The difference is less than one percentage point, suggrestiong
    
    