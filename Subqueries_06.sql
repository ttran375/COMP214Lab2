-- 6. List the title of all books in the same category as books previously 
-- purchased by customer 1007. Don’t include books this customer has already 
-- purchased.
SELECT DISTINCT
    B.Title
FROM
    Orders O
JOIN
    Orderitems Oi ON O.Order# = Oi.Order#
JOIN
    Books B ON Oi.Isbn = B.Isbn
WHERE
    O.Customer# <> 1007
AND
    B.Category IN (
        SELECT DISTINCT
            B.Category
        FROM
            Orders O
        JOIN
            Orderitems Oi ON O.Order# = Oi.Order#
        JOIN
            Books B ON Oi.Isbn = B.Isbn
        WHERE
            O.Customer# = 1007
    );
