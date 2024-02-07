-- 1. List the book title and retail price for all books with a retail price
-- lower than the average retail price of all books sold by JustLee Books.
SELECT
    Title,
    Retail
FROM
    Books
WHERE
    Retail < (SELECT AVG(Retail) FROM Books);

-- 2. Determine which books cost less than the average cost of other books in 
-- the same category.
SELECT
    A.Title,
    B.Category,
    A.Cost
FROM
    Books AS A,
    (
        SELECT
            Category,
            AVG(Cost) AS Averagecost
        FROM
            Books
        GROUP BY
            Category
    ) AS B
WHERE
    A.Category = B.Category
    AND A.Cost < B.Averagecost;

-- 3. Determine which orders were shipped to the same state as order 1014.
SELECT Order#
FROM Orders
WHERE Shipstate = (
    SELECT Shipstate
    FROM Orders
    WHERE Order# = 1014
)
AND Order# <> 1014;
