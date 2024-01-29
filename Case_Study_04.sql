-- 4. A list of all amounts owed is needed. Create a list showing each criminal name, charge ID, total amount owed (fine amount plus court fee), amount paid, amount owed, and payment due date. If nothing has been paid to date, the amount paid is NULL. Include only criminals who owe some amount of money. Display the dollar amounts with a dollar sign and two decimals.
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
