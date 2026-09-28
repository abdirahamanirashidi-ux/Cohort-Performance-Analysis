-- 08_course_cohort_ranking.sql
-- purpose rank every course / cohort combination that has run in the program
-- by attendance rate, alongside its completion rate to spot which specific
-- offering are underperforming and whether any course repeats near the
-- bottom across multiple cohorts

WITH att AS (
	SELECT 
    e.course_id,
    e.cohort_id,
    ROUND(100.0 * SUM(a.status IN ('present', 'Late'))
		/ COUNT(*), 1) AS attendance_rate
FROM enrolments e
JOIN attendance a ON a.enrolment_id = e.enrolment_id
WHERE a.status != 'Not Recorded'
GROUP BY e.couse_id, e.cohort_id
),
comp AS (
	SELECT
		course_id,
        cohort_id,
        ROUND(100.0 * SUM(status = 'completed')
			/ COUNT(*), 1) AS completion_rate,
		COUNT(*) AS enrolled
	FROM enrolments
    GROUP BY course_id, cohort_id
)
SELECT
	c.course_name,
    att.cohort_id,
    att.attendance_rate,
    comp.completion_rate,
    comp.enrolled
FROM att
JOIN comp
	ON att.course_id = comp.course_id
    AND att.cohort_id = comp.cohort_id
JOIN courses c ON c.course_id = attcourse_id
ORDER BY att.attendance-rate ASC;
	
    
    -- Result: Data Analysis appear twice in the weakest five (cohort 4 and 
    -- Cohort 5), suggestion a course level pattern rather than one bad cohort.
    -- Completion rates for cohorts 4, 5 and 6 read low across almost every row
    -- here becouse of the unknown-status data quality issue documented in 
    -- 01_data_quality_checks.sql not becouse those cohorts genuinely performed
    -- worse. Read completion figures for those cohorts with that caveat atteched.
    

    