-- 1. List the book title and retail price for all books with a retail price
-- lower than the average retail price of all books sold by JustLee Books.
SELECT
    B.Title,
    B.Retail
FROM
    Books B
WHERE
    B.Retail < (SELECT AVG(B2.Retail) FROM Books B2);

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
) AS AvgCostByCategory ON B.Category = AvgCostByCategory.Category
WHERE
    B.Cost < AvgCostByCategory.AverageCost;

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
    SUM(Quantity * Paideach) AS TotalAmountDue
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
    COUNT(*) AS PurchaseCount
FROM
    Author A
JOIN
    Bookauthor Ba ON A.Authorid = Ba.Authorid
JOIN
    Orderitems Oi ON Ba.Isbn = Oi.Isbn
JOIN
    Orders O ON Oi.Order# = O.Order#
WHERE
    O.Customer# IN (SELECT Customer# FROM Orders)
GROUP BY
    A.Authorid, A.Lname, A.Fname
ORDER BY
    PurchaseCount DESC
FETCH FIRST 1 ROW ONLY;

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
    Shippingdelay DESC
FETCH FIRST 1 ROWS ONLY;

-- 8. Determine which customers placed orders for the least expensive book (in 
-- terms of regular retail price) carried by JustLee Books.
SELECT DISTINCT
    C.Customer#,
    C.Firstname,
    C.Lastname,
    O.Order#
FROM
    Customers C
JOIN
    Orders O ON C.Customer# = O.Customer#
JOIN
    Orderitems Oi ON O.Order# = Oi.Order#
JOIN
    Books B ON Oi.Isbn = B.Isbn
ORDER BY
    B.Retail
FETCH FIRST 1 ROWS ONLY;

-- 9. Determine the number of different customers who have placed an order for 
-- books written or cowritten by James Austin.
SELECT COUNT(DISTINCT C.Customer#) AS Numberofcustomers
FROM
    Customers C
JOIN
    Orders O ON C.Customer# = O.Customer#
JOIN
    Orderitems Oi ON O.Order# = Oi.Order#
JOIN
    Bookauthor Ba ON Oi.Isbn = Ba.Isbn
JOIN
    Author A ON Ba.Authorid = A.Authorid
WHERE
    A.Lname = 'AUSTIN'
AND
    A.Fname = 'JAMES';

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
