-- 9. Determine the number of different customers who have placed an order for books written or cowritten by James Austin.
SELECT
  COUNT(DISTINCT C.Customer#) AS Numberofcustomers
FROM
  Customers  C
  JOIN Orders O
  ON C.Customer# = O.Customer#
  JOIN Orderitems Oi
  ON O.Order# = Oi.Order#
  JOIN Bookauthor Ba
  ON Oi.Isbn = Ba.Isbn
  JOIN Author A
  ON Ba.Authorid = A.Authorid
WHERE
  A.Lname = 'AUSTIN'
  AND A.Fname = 'JAMES';