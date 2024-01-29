-- 9. Determine the number of different customers who have placed an order for books written or cowritten by James Austin. 
SELECT
  COUNT(DISTINCT c.Customer#) AS NumberOfCustomers
FROM
  Customers c
  JOIN Orders o ON c.Customer# = o.Customer#
  JOIN OrderItems oi ON o.Order# = oi.Order#
  JOIN BookAuthor ba ON oi.ISBN = ba.ISBN
  JOIN Author a ON ba.AuthorID = a.AuthorID
WHERE
  a.Lname = 'AUSTIN'
  AND a.Fname = 'JAMES';
