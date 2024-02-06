-- 8. Determine which customers placed orders for the least expensive book (in 
-- terms of regular retail price) carried by JustLee Books.
SELECT DISTINCT
    C.Customer#,
    C.Firstname,
    C.Lastname,
    O.Order#
FROM
    Customers C
JOIN
    Orders O ON C.Customer# = O.Customer#
JOIN
    Orderitems Oi ON O.Order# = Oi.Order#
JOIN
    Books B ON Oi.Isbn = B.Isbn
ORDER BY
    B.Retail
FETCH FIRST 1 ROWS ONLY;

