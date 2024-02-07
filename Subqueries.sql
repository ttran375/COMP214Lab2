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

