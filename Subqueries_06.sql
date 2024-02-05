-- 6. List the title of all books in the same category as books previously purchased by customer 1007. Don’t include books this customer has already purchased.
SELECT
  DISTINCT B.Title
FROM
  Orders     O,
  Orderitems Oi,
  Books      B
WHERE
  O.Order# = Oi.Order#
  AND Oi.Isbn = B.Isbn
  AND B.Category IN (
    SELECT
      DISTINCT B.Category
    FROM
      Orders     O,
      Orderitems Oi,
      Books      B
    WHERE
      O.Order# = Oi.Order#
      AND Oi.Isbn = B.Isbn
      AND O.Customer# = 1007
  )
  AND B.Isbn NOT IN (
    SELECT
      Isbn
    FROM
      Orderitems
    WHERE
      Order# IN (
        SELECT
          Order#
        FROM
          Orders
        WHERE
          Customer# = 1007
      )
  );
