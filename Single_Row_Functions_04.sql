-- 4. Display a list of all book titles and the percentage of markup for each book. The percentage of markup should be displayed as a whole number (that is, multiplied by 100) with no decimal position, followed by a percent sign (for example, .2793 = 28%). (The percentage of markup should reflect the difference between the retail and cost amounts as a percent of the cost.).
SELECT
    Title,
    TO_CHAR(((Retail - Cost) / Cost) * 100, '999') || '%' AS MarkupPercentage
FROM
    Books;
