-- 7. List the shipping city and state for the order that had the longest 
-- shipping delay.
SELECT
    Order#,
    Shipcity,
    Shipstate,
    Shipdate - Orderdate AS Shippingdelay
FROM
    Orders
WHERE
    Shipdate IS NOT NULL
ORDER BY
    Shippingdelay DESC
FETCH FIRST 1 ROWS ONLY;
