-- 5. Display the criminal name and probation start date for all criminals who have a probation period greater than two months. Also, display the date that’s two months from the beginning of the probation period, which will serve as a review date.
SELECT
  c.last || ', ' || c.first AS criminal_name,
  s.start_date AS probation_start_date,
  ADD_MONTHS(s.start_date, 2) AS review_date
FROM
  criminals_dw c
  JOIN sentences s ON c.criminal_id = s.criminal_id
WHERE
  s.type = 'P'
  AND MONTHS_BETWEEN(s.end_date, s.start_date) > 2;
