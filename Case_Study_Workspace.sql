-- **Case Study**
-- Note: Make sure you have run the CityJail_8.sql script from Chapter 8.
-- This script makes all database objects available for completing this
-- case study. The following list reflects current data requests from city
-- managers. Provide the SQL statement to satisfy each request. Test the
-- statements and show execution results.
-- 1.  List the following information for all crimes that have a period
--     greater than 14 days between the date charged and the hearing date:
--     crime ID, classification, date charged, hearing date, and number of
--     days between the date charged and the hearing date.
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

-- 2.  Produce a list showing each active police officer and his or her
--     community assignment, indicated by the second letter of the precinct
--     code. Display the community description listed in the following
--     chart, based on the second letter of the precinct code.
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

-- 3.  Produce a list of sentencing information to include criminal ID,
--     name (displayed in all uppercase letters), sentence ID, sentence
--     start date, and length in months of the sentence. The number of
--     months should be shown as a whole number. The start date should be
--     displayed in the format “December 17, 2009.”
SELECT
  s.criminal_id,
  UPPER(c.last) || ', ' || UPPER(c.first) AS criminal_name,
  s.sentence_id,
  TO_CHAR(s.start_date, 'Month DD, YYYY') AS start_date,
  MONTHS_BETWEEN(s.end_date, s.start_date) AS sentence_length_months
FROM
  sentences s
  JOIN criminals c ON s.criminal_id = c.criminal_id;

-- 4.  A list of all amounts owed is needed. Create a list showing each
--     criminal name, charge ID, total amount owed (fine amount plus court
--     fee), amount paid, amount owed, and payment due date. If nothing has
--     been paid to date, the amount paid is NULL. Include only criminals
--     who owe some amount of money. Display the dollar amounts with a
--     dollar sign and two decimals.
SELECT
  UPPER(c.last) || ', ' || UPPER(c.first) AS criminal_name,
  cc.charge_id,
  TO_CHAR(cc.fine_amount + cc.court_fee, '$99999.99') AS total_amount_owed,
  TO_CHAR(cc.amount_paid, '$99999.99') AS amount_paid,
  TO_CHAR(
    (cc.fine_amount + cc.court_fee) - NVL(cc.amount_paid, 0),
    '$99999.99'
  ) AS amount_owed,
  TO_CHAR(cc.pay_due_date, 'Month DD, YYYY') AS payment_due_date
FROM
  crime_charges cc
  JOIN crimes cr ON cc.crime_id = cr.crime_id
  JOIN criminals c ON cr.criminal_id = c.criminal_id
WHERE
  (cc.fine_amount + cc.court_fee) - NVL(cc.amount_paid, 0) > 0;

-- 5.  Display the criminal name and probation start date for all criminals
--     who have a probation period greater than two months. Also, display
--     the date that’s two months from the beginning of the probation
--     period, which will serve as a review date.
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

-- 6.  An INSERT statement is needed to support users adding a new appeal.
--     Create an INSERT statement using substitution variables. Note that
--     users will be entering dates in the format of a two-digit month, a
--     two-digit day, and a four-digit year, such as “12 17 2009.” In
--     addition, a sequence named APPEALS_ID_SEQ exists to supply values
--     for the Appeal_ID column, and the default setting for the Status
--     column should take effect (that is, the DEFAULT option on the column
--     should be used).
-- Test the statement by adding the following appeal:
-- crime_ID ¼ 25344031, filing date ¼ 02 13 2009, and hearing date ¼ 02 27
-- 2009.
CREATE
OR REPLACE PROCEDURE insert_appeal (
  p_crime_id NUMBER DEFAULT 25344031,
  p_filing_date VARCHAR2 DEFAULT '02 13 2009',
  p_hearing_date VARCHAR2 DEFAULT '02 27 2009'
) AS
BEGIN
INSERT INTO
  appeals (appeal_id, crime_id, filing_date, hearing_date)
VALUES
  (
    appeals_id_seq.NEXTVAL,
    p_crime_id,
    TO_DATE(p_filing_date, 'MM DD YYYY'),
    TO_DATE(p_hearing_date, 'MM DD YYYY')
  );

END;

/
