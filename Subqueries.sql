-- 1. List the book title and retail price for all books with a retail price
-- lower than the average retail price of all books sold by JustLee Books.
SELECT
    Title,
    Retail
FROM
    Books
WHERE
    Retail < (
        SELECT
            AVG(Retail)
        FROM
            Books
    );

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

-- 3. Determine which orders were shipped to the same state as order 1014.
SELECT
    Order#
FROM
    Orders
WHERE
    Shipstate = (
        SELECT
            Shipstate
        FROM
            Orders
        WHERE
            Order# = 1014
    )
    AND Order# <> 1014;

-- 4. Determine which orders had a higher total amount due than order 1008.
SELECT
    Order#,
    SUM(Quantity * Paideach)
FROM
    Orderitems
GROUP BY
    Order#
HAVING
    SUM(Quantity * Paideach) > (
        SELECT
            SUM(Quantity * Paideach)
        FROM
            Orderitems
        WHERE
            Order# = 1008
    );

-- 5. Determine which author or authors wrote the books most frequently 
-- purchased by customers of JustLee Books.
SELECT
    A.Authorid,
    A.Lname,
    A.Fname,
    (
        SELECT
            COUNT(*)
        FROM
            Orderitems Oi
        WHERE
            Oi.Isbn IN (
                SELECT
                    Ba.Isbn
                FROM
                    Bookauthor Ba
                WHERE
                    Ba.Authorid = A.Authorid
            )
    ) AS Purchasecount
FROM
    Author A
ORDER BY
    Purchasecount DESC FETCH FIRST 1 ROW ONLY;

-- 6. List the title of all books in the same category as books previously 
-- purchased by customer 1007. Don’t include books this customer has already 
-- purchased.
SELECT
    DISTINCT B.Title
FROM
    Orders     O,
    Orderitems Oi,
    Books      B
WHERE
    O.Order# = Oi.Order#
    AND Oi.Isbn = B.Isbn
    AND B.Category IN (
        SELECT
            DISTINCT B.Category
        FROM
            Orders     O,
            Orderitems Oi,
            Books      B
        WHERE
            O.Order# = Oi.Order#
            AND Oi.Isbn = B.Isbn
            AND O.Customer# = 1007
    )
    AND B.Isbn NOT IN (
        SELECT
            Isbn
        FROM
            Orderitems
        WHERE
            Order# IN (
                SELECT
                    Order#
                FROM
                    Orders
                WHERE
                    Customer# = 1007
            )
    );

-- 7. List the shipping city and state for the order that had the longest 
-- shipping delay.
SELECT
    Order#,
    Shipcity,
    Shipstate,
    Shipdate - Orderdate AS Shippingdelay
FROM
    Orders
WHERE
    Shipdate IS NOT NULL
ORDER BY
    Shippingdelay DESC FETCH FIRST 1 ROWS ONLY;

-- 8. Determine which customers placed orders for the least expensive book (in 
-- terms of regular retail price) carried by JustLee Books.
SELECT
    DISTINCT C.Customer#,
    C.Firstname,
    C.Lastname,
    O.Order#
FROM
    Customers  C
    JOIN Orders O
    ON C.Customer# = O.Customer#
    JOIN Orderitems Oi
    ON O.Order# = Oi.Order#
    JOIN Books B
    ON Oi.Isbn = B.Isbn
ORDER BY
    B.Retail FETCH FIRST 1 ROWS ONLY;

-- 9. Determine the number of different customers who have placed an order for 
-- books written or cowritten by James Austin.
SELECT
    COUNT(DISTINCT C.Customer#) AS Numberofcustomers
FROM
    Customers  C
    JOIN Orders O
    ON C.Customer# = O.Customer#
    JOIN Orderitems Oi
    ON O.Order# = Oi.Order#
    JOIN Bookauthor Ba
    ON Oi.Isbn = Ba.Isbn
    JOIN Author A
    ON Ba.Authorid = A.Authorid
WHERE
    A.Lname = 'AUSTIN'
    AND A.Fname = 'JAMES';

-- 10. Determine which books were published by the publisher of The Wok Way to 
-- Cook.
SELECT
    Title
FROM
    Books
WHERE
    Pubid = (
        SELECT
            Pubid
        FROM
            Books
        WHERE
            Title = 'THE WOK WAY TO COOK'
    );