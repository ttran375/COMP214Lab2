-- 1. List the following information for all crimes that have a period greater than 14 days between the date charged and the hearing date: crime ID, classification, date charged, hearing date, and number of days between the date charged and the hearing date.
SELECT
  c.crime_id,
  c.classification,
  c.date_charged,
  c.hearing_date,
  c.hearing_date - c.date_charged AS days_between
FROM
  crimes c
WHERE
  c.hearing_date - c.date_charged > 14;
