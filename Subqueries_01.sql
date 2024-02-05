-- 1. List the book title and retail price for all books with a retail price lower than the average retail price of all books sold by JustLee Books.
Select
  TITLE,
  RETAIL
From
  BOOKS
Where
  RETAIL < (
    Select
      Avg(RETAIL)
    From
      BOOKS
  );
