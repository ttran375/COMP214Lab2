-- 3. Determine which orders were shipped to the same state as order 1014.
SELECT
    Order#
FROM
    Orders
WHERE
    Shipstate = (
        SELECT
            Shipstate
        FROM
            Orders
        WHERE
            Order# = 1014
    )
    AND Order# <> 1014;
