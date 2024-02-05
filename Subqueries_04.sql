-- 4. Determine which orders had a higher total amount due than order 1008.
SELECT
  Order#,
  SUM(Quantity * Paideach)
FROM
  Orderitems
GROUP BY
  Order#
HAVING
  SUM(Quantity * Paideach) > (
    SELECT
      SUM(Quantity * Paideach)
    FROM
      Orderitems
    WHERE
      Order# = 1008
  );