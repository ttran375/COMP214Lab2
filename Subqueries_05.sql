-- 5. Determine which author or authors wrote the books most frequently 
-- purchased by customers of JustLee Books.
SELECT
    A.Authorid,
    A.Lname,
    A.Fname,
    COUNT(*) AS PurchaseCount
FROM
    Author A
JOIN
    Bookauthor Ba ON A.Authorid = Ba.Authorid
JOIN
    Orderitems Oi ON Ba.Isbn = Oi.Isbn
JOIN
    Orders O ON Oi.Order# = O.Order#
WHERE
    O.Customer# IN (SELECT Customer# FROM Orders)
GROUP BY
    A.Authorid, A.Lname, A.Fname
ORDER BY
    PurchaseCount DESC
FETCH FIRST 1 ROW ONLY;
