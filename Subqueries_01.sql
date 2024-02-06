-- 1. List the book title and retail price for all books with a retail price
-- lower than the average retail price of all books sold by JustLee Books.
SELECT
    B.Title,
    B.Retail
FROM
    Books B
WHERE
    B.Retail < (SELECT AVG(B2.Retail) FROM Books B2);
