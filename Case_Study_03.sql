-- 3. Produce a list of sentencing information to include criminal ID, name (displayed in all uppercase letters), sentence ID, sentence start date, and length in months of the sentence. The number of months should be shown as a whole number. The start date should be displayed in the format “December 17, 2009.”
SELECT
  s.criminal_id,
  UPPER(c.last) || ', ' || UPPER(c.first) AS criminal_name,
  s.sentence_id,
  TO_CHAR(s.start_date, 'Month DD, YYYY') AS start_date,
  MONTHS_BETWEEN(s.end_date, s.start_date) AS sentence_length_months
FROM
  sentences s
  JOIN criminals c ON s.criminal_id = c.criminal_id;
