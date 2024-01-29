-- 8. Determine which customers placed orders for the least expensive book (in terms of regular retail price) carried by JustLee Books.
SELECT
  C.Customer#,
  C.LastName,
  C.FirstName,
  O.Order#,
  B.Title AS BookTitle,
  B.Retail AS RetailPrice
FROM
  Customers C
  JOIN Orders O ON C.Customer# = O.Customer#
  JOIN OrderItems OI ON O.Order# = OI.Order#
  JOIN Books B ON OI.ISBN = B.ISBN
WHERE
  B.Retail = (
    SELECT
      MIN(Retail)
    FROM
      Books
  )
ORDER BY
  B.Retail;
