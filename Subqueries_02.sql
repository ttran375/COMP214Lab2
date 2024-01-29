-- 2. Determine which books cost less than the average cost of other books in the same category.
SELECT
  b.ISBN,
  b.Title,
  b.Category,
  b.Cost,
  AVG(b2.Cost) AS AvgCategoryCost
FROM
  Books b
  JOIN Books b2 ON b.Category = b2.Category
  AND b.ISBN <> b2.ISBN
GROUP BY
  b.ISBN,
  b.Title,
  b.Category,
  b.Cost
HAVING
  b.Cost < AVG(b2.Cost);
