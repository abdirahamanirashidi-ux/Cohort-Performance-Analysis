SELECT
	SUM(email = '') missing_email,
    SUM(phone = '') missing_phone
FROM students;

-- 75% of students have missing contract details

-- How many attendance sessions have no status recorded at all

SELECT status, COUNT(*) AS n
FROM attendance
GROUP BY status
ORDER BY n DESC;


SELECT 
	ROUND(100.0 * SUM(status = 'not recoded') / COUNT(*), 2) AS p
FROM attendance;

-- DEcision made from this results, applied in every query from here 
-- * Not recorded attendance rows are exclosed from attendance 
-- (Naither counted as atteded nor as absent)
-- * Unknown enrolments status is kept as its own category