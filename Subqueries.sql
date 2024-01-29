-- 1. List the book title and retail price for all books with a retail price lower than the average retail price of all books sold by JustLee Books.
SELECT
  title,
  retail
FROM
  books
WHERE
  retail < (
    SELECT
      AVG(retail)
    FROM
      books
  );

-- 2. Determine which books cost less than the average cost of other books in the same category.
SELECT
  a.title,
  b.category,
  a.cost
FROM
  books a,
  (
    SELECT
      category,
      AVG(cost) averagecost
    FROM
      books
    GROUP BY
      category
  ) b
WHERE
  a.category = b.category
  AND a.cost < b.averagecost;

-- 3. Determine which orders were shipped to the same state as order 1014.
SELECT
  order#
FROM
  orders
WHERE
  shipstate = (
    SELECT
      shipstate
    FROM
      orders
    WHERE
      order# = 1014
  )
  AND order# <> 1014;

-- 4. Determine which orders had a higher total amount due than order 1008.
SELECT
  order#,
  SUM(quantity * paideach)
FROM
  orderitems
GROUP BY
  order#
HAVING
  SUM(quantity * paideach) > (
    SELECT
      SUM(quantity * paideach)
    FROM
      orderitems
    WHERE
      order# = 1008
  );

-- 5. Determine which author or authors wrote the books most frequently purchased by customers of JustLee Books.
SELECT
    BA.AuthorID,
    A.Lname,
    A.Fname,
    COUNT(*) AS PurchaseCount
FROM
    OrderItems OI
JOIN
    Books B ON OI.ISBN = B.ISBN
JOIN
    BookAuthor BA ON B.ISBN = BA.ISBN
JOIN
    Author A ON BA.AuthorID = A.AuthorID
GROUP BY
    BA.AuthorID, A.Lname, A.Fname
ORDER BY
    PurchaseCount DESC;

SELECT
    A.AuthorID,
    A.Lname,
    A.Fname,
    (
        SELECT COUNT(*)
        FROM OrderItems OI
        WHERE OI.ISBN IN (
            SELECT BA.ISBN
            FROM BookAuthor BA
            WHERE BA.AuthorID = A.AuthorID
        )
    ) AS PurchaseCount
FROM
    Author A
ORDER BY
    PurchaseCount DESC;

-- SELECT
--     BA.AuthorID,
--     A.Lname,
--     A.Fname,
--     (
--         SELECT COUNT(*)
--         FROM OrderItems OI
--         WHERE OI.ISBN IN (
--             SELECT B.ISBN
--             FROM Books B
--             WHERE B.ISBN = BA.ISBN
--         )
--     ) AS PurchaseCount
-- FROM
--     BookAuthor BA
-- JOIN
--     Author A ON BA.AuthorID = A.AuthorID
-- ORDER BY
--     PurchaseCount DESC;



-- 6. List the title of all books in the same category as books previously purchased by customer 1007. Don’t include books this customer has already purchased.
SELECT DISTINCT
  B.TITLE
FROM
  BOOKS B
  JOIN BOOKAUTHOR BA ON B.ISBN = BA.ISBN
  JOIN AUTHOR A ON BA.AUTHORID = A.AUTHORID
WHERE
  B.CATEGORY IN (
    SELECT DISTINCT
      B.CATEGORY
    FROM
      CUSTOMERS C
      JOIN ORDERS O ON C.CUSTOMER# = O.CUSTOMER#
      JOIN ORDERITEMS OI ON O.ORDER# = OI.ORDER#
      JOIN BOOKS B ON OI.ISBN = B.ISBN
    WHERE
      C.CUSTOMER# = 1007
  )
  AND B.ISBN NOT IN (
    SELECT
      ISBN
    FROM
      ORDERITEMS
    WHERE
      ORDER# IN (
        SELECT
          ORDER#
        FROM
          ORDERS
        WHERE
          CUSTOMER# = 1007
      )
  )
ORDER BY
  B.TITLE;

-- 7. List the shipping city and state for the order that had the longest shipping delay.
SELECT
  shipcity,
  shipstate
FROM
  orders
WHERE
  shipdate - orderdate = (
    SELECT
      MAX(shipdate - orderdate)
    FROM
      orders
  );

-- 8. Determine which customers placed orders for the least expensive book (in terms of regular retail price) carried by JustLee Books.
SELECT
  customer#
FROM
  customers
  JOIN orders USING (customer#)
  JOIN orderitems USING (order#)
  JOIN books USING (isbn)
WHERE
  retail = (
    SELECT
      MIN(retail)
    FROM
      books
  );

-- 9. Determine the number of different customers who have placed an order for books written or cowritten by James Austin.
SELECT
  COUNT(DISTINCT C.CUSTOMER#) AS NUMBEROFCUSTOMERS
FROM
  CUSTOMERS C
  JOIN ORDERS O ON C.CUSTOMER# = O.CUSTOMER#
  JOIN ORDERITEMS OI ON O.ORDER# = OI.ORDER#
  JOIN BOOKAUTHOR BA ON OI.ISBN = BA.ISBN
  JOIN AUTHOR A ON BA.AUTHORID = A.AUTHORID
WHERE
  A.LNAME = 'AUSTIN'
  AND A.FNAME = 'JAMES';

-- 10. Determine which books were published by the publisher of The Wok Way to Cook.
SELECT
  title
FROM
  books
WHERE
  pubid = (
    SELECT
      pubid
    FROM
      books
    WHERE
      title = 'THE WOK WAY TO COOK'
  );
