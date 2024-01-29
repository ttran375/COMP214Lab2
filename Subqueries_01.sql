-- 1. List the book title and retail price for all books with a retail price lower than the average retail price of all books sold by JustLee Books.
SELECT
  b.Title,
  b.Retail
FROM
  Books b
WHERE
  b.Retail < (
    SELECT
      AVG(b2.Retail)
    FROM
      Books b2
  );
