-- 2. Produce a list showing each active police officer and his or her community assignment, indicated by the second letter of the precinct code. Display the community description listed in the following chart, based on the second letter of the precinct code.
SELECT
  o.officer_id,
  o.last || ', ' || o.first AS officer_name,
  o.precinct,
  CASE SUBSTR(o.precinct, 2, 1)
    WHEN 'C' THEN 'City Center'
    WHEN 'H' THEN 'Harbor'
    WHEN 'A' THEN 'Airport'
    WHEN 'W' THEN 'Westside'
    ELSE 'Unknown'
  END AS community_assignment
FROM
  officers o
WHERE
  o.status = 'A';
