-- 4. Determine which orders had a higher total amount due than order 1008.
SELECT
  Order# AS OrderID,
  TotalAmountDue
FROM
  (
    SELECT
      o.Order#,
      o.Customer#,
      o.OrderDate,
      o.ShipDate,
      o.ShipStreet,
      o.ShipCity,
      o.ShipState,
      o.ShipZip,
      o.ShipCost,
      SUM(o.ShipCost) OVER (
        PARTITION BY
          o.Order#
      ) AS TotalAmountDue
    FROM
      Orders o
    WHERE
      o.Order# <> 1008
  )
WHERE
  TotalAmountDue > (
    SELECT
      SUM(o.ShipCost) AS TotalAmountDue
    FROM
      Orders o
    WHERE
      o.Order# = 1008
  );
