-- 5. Display the criminal name and probation start date for all criminals who have a probation period greater than two months. Also, display the date that’s two months from the beginning of the probation period, which will serve as a review date.
SELECT
  UPPER(c.last) || ', ' || UPPER(c.first) AS criminal_name,
  p.start_date AS probation_start_date,
  ADD_MONTHS(p.start_date, 2) AS review_date
FROM
  sentences s
  JOIN criminals c ON s.criminal_id = c.criminal_id
  JOIN prob_officers po ON s.prob_id = po.prob_id
  JOIN prob_contact pc ON po.status = pc.prob_cat
  JOIN prob_officers p ON s.prob_id = p.prob_id
WHERE
  pc.con_freq = 'Monthly'
  AND MONTHS_BETWEEN(p.end_date, p.start_date) > 2;
