-- 6. List the title of all books in the same category as books previously purchased by customer 1007. Don’t include books this customer has already purchased.
SELECT DISTINCT
  b.Title
FROM
  Books b
  JOIN BookAuthor ba ON b.ISBN = ba.ISBN
  JOIN Author a ON ba.AuthorID = a.AuthorID
WHERE
  b.Category IN (
    SELECT DISTINCT
      b.Category
    FROM
      Customers c
      JOIN Orders o ON c.Customer# = o.Customer#
      JOIN OrderItems oi ON o.Order# = oi.Order#
      JOIN Books b ON oi.ISBN = b.ISBN
    WHERE
      c.Customer# = 1007
  )
  AND b.ISBN NOT IN (
    SELECT
      ISBN
    FROM
      OrderItems
    WHERE
      Order# IN (
        SELECT
          Order#
        FROM
          Orders
        WHERE
          Customer# = 1007
      )
  )
ORDER BY
  b.Title;
