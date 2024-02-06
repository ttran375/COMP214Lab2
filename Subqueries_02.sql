-- 2. Determine which books cost less than the average cost of other books in 
-- the same category.
SELECT
    B.Title,
    B.Category,
    B.Cost
FROM
    Books B
JOIN (
    SELECT
        Category,
        AVG(Cost) AS AverageCost
    FROM
        Books
    GROUP BY
        Category
) AvgCostByCategory ON B.Category = AvgCostByCategory.Category
WHERE
    B.Cost < AvgCostByCategory.AverageCost;
