-- step 1
-- assignment meaning a handoff happened

WITH multiple_instructors AS(
	SELECT
    course_id,
    cohort_id,
    COUNT(*) AS assignments
FROM instructor_assignments
GROUP BY course_id, cohort_id
HAVING COUNT(*) > 1
)

-- step2 Attendance rate per instructor before and after the handoff
SELECT 
	i.instructor_id,
    i.start_date,
    i.end_date,
    ROUND(
		SUM(a.status IN('present', 'Late')) / COUNT(*) *100, 1
	) AS attendance_rate,
    COUNT(*) sessions
FROM instructor_assignments i
JOIN enrolments e ON i.course_id = e.course_id AND i.cohort_id = e.cohort_id

JOIN attendance a ON e.enrolment_id = a.enrolment_id
	AND a.session_date BETWEEN i.start_date AND i.end_date
    
WHERE (i.course_id, i.cohort_id) IN (SELECT course_id, cohort_id FROM multiple_instructors)
	AND a.status <> 'Not Recorded'
GROUP BY i.instructor_id, stat_date, end_date
ORDER BY start_date;
