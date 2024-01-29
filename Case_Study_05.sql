-- 5. Display the criminal name and probation start date for all criminals who have a probation period greater than two months. Also, display the date that’s two months from the beginning of the probation period, which will serve as a review date.
select
  c.last || ', ' || c.first as criminal_name,
  s.start_date as probation_start_date,
  add_months(s.start_date, 2) as review_date
from
  criminals_dw c
  join sentences s on c.criminal_id = s.criminal_id
where
  s.type = 'P'
  and round(months_between(s.end_date, s.start_date)) > 2;
