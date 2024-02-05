-- 2. Determine which books cost less than the average cost of other books in the same category.
SELECT
  A.Title,
  B.Category,
  A.Cost
FROM
  Books A,
  (
    SELECT
      Category,
      AVG(Cost) Averagecost
    FROM
      Books
    GROUP BY
      Category
  )     B
WHERE
  A.Category = B.Category
  AND A.Cost < B.Averagecost;
