-- 5. Determine which author or authors wrote the books most frequently purchased by customers of JustLee Books.
SELECT
  ba.ISBN,
  b.Title,
  a.Lname,
  a.Fname
FROM
  BOOKAUTHOR ba
  JOIN AUTHOR a ON ba.AuthorID = a.AuthorID
  JOIN BOOKS b ON ba.ISBN = b.ISBN
  JOIN (
    SELECT
      oi.ISBN,
      COUNT(oi.ISBN) AS PurchaseCount
    FROM
      ORDERITEMS oi
    GROUP BY
      oi.ISBN
    ORDER BY
      PurchaseCount DESC
    FETCH FIRST
      1 ROWS ONLY
  ) tp ON ba.ISBN = tp.ISBN
ORDER BY
  tp.PurchaseCount DESC,
  a.Lname,
  a.Fname;
