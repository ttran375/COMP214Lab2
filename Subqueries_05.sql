-- 5. Determine which author or authors wrote the books most frequently purchased by customers of JustLee Books.
SELECT
  A.Authorid,
  A.Lname,
  A.Fname,
  (
    SELECT
      COUNT(*)
    FROM
      Orderitems Oi
    WHERE
      Oi.Isbn IN (
        SELECT
          Ba.Isbn
        FROM
          Bookauthor Ba
        WHERE
          Ba.Authorid = A.Authorid
      )
  ) AS Purchasecount
FROM
  Author A
ORDER BY
  Purchasecount DESC FETCH FIRST 1 ROW ONLY;