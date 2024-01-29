-- 6. Create a list of all book titles and costs. Precede each book’s cost with asterisks so that the width of the displayed Cost field is 12.
SELECT
    Title,
    LPAD(TO_CHAR(Cost, '99.99'), 12, '*') AS DisplayedCost
FROM
    Books;
