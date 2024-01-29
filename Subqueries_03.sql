-- 3. Determine which orders were shipped to the same state as order 1014.
SELECT DISTINCT
  o.Order#
FROM
  Orders o
WHERE
  o.ShipState = (
    SELECT
      ShipState
    FROM
      Orders
    WHERE
      Order# = 1014
  )
  AND o.Order# <> 1014;
