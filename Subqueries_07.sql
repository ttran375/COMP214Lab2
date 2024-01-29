-- 7. List the shipping city and state for the order that had the longest shipping delay.
SELECT
  o.Order#,
  o.ShipCity,
  o.ShipState,
  (o.ShipDate - o.OrderDate) AS ShippingDelay
FROM
  Orders o
WHERE
  o.ShipDate IS NOT NULL
ORDER BY
  ShippingDelay DESC
FETCH FIRST
  1 ROW ONLY;
