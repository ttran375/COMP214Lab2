-- 1. List the book title and retail price for all books with a retail price lower than the average retail price of all books sold by JustLee Books.
SELECT
  B.TITLE,
  B.RETAIL
FROM
  BOOKS B
WHERE
  B.RETAIL < (
    SELECT
      AVG(B2.RETAIL)
    FROM
      BOOKS B2
  );

-- 2. Determine which books cost less than the average cost of other books in the same category.
SELECT
  B.ISBN,
  B.TITLE,
  B.CATEGORY,
  B.COST,
  AVG(B2.COST) AS AVGCATEGORYCOST
FROM
  BOOKS B
  JOIN BOOKS B2 ON B.CATEGORY = B2.CATEGORY
  AND B.ISBN <> B2.ISBN
GROUP BY
  B.ISBN,
  B.TITLE,
  B.CATEGORY,
  B.COST
HAVING
  B.COST < AVG(B2.COST);

-- 3. Determine which orders were shipped to the same state as order 1014.
SELECT DISTINCT
  O.ORDER#
FROM
  ORDERS O
WHERE
  O.SHIPSTATE = (
    SELECT
      SHIPSTATE
    FROM
      ORDERS
    WHERE
      ORDER# = 1014
  )
  AND O.ORDER# <> 1014;

-- 4. Determine which orders had a higher total amount due than order 1008.
WITH OrderTotals AS (
  SELECT
    o.Order#,
    COALESCE(SUM(b.Retail * oi.Quantity), 0) AS TotalAmountDue
  FROM
    Orders o
    LEFT JOIN OrderItems oi ON o.Order# = oi.Order#
    LEFT JOIN Books b ON oi.ISBN = b.ISBN
  GROUP BY
    o.Order#
)
SELECT
  ot.Order#,
  ot.TotalAmountDue,
  CASE
    WHEN ot.TotalAmountDue > o1008.TotalAmountDue THEN 'Higher'
    WHEN ot.TotalAmountDue < o1008.TotalAmountDue THEN 'Lower'
    ELSE 'Equal'
  END AS ComparisonWithOrder1008
FROM
  OrderTotals ot
  CROSS JOIN (
    SELECT
      COALESCE(SUM(b.Retail * oi.Quantity), 0) AS TotalAmountDue
    FROM
      OrderItems oi
      JOIN Books b ON oi.ISBN = b.ISBN
    WHERE
      oi.Order# = 1008
  ) o1008
ORDER BY
  ot.Order#;


-- 5. Determine which author or authors wrote the books most frequently purchased by customers of JustLee Books.
SELECT
  BA.ISBN,
  B.TITLE,
  A.LNAME,
  A.FNAME
FROM
  BOOKAUTHOR BA
  JOIN AUTHOR A ON BA.AUTHORID = A.AUTHORID
  JOIN BOOKS B ON BA.ISBN = B.ISBN
  JOIN (
    SELECT
      OI.ISBN,
      COUNT(OI.ISBN) AS PURCHASECOUNT
    FROM
      ORDERITEMS OI
    GROUP BY
      OI.ISBN
    ORDER BY
      PURCHASECOUNT DESC
    FETCH FIRST
      1 ROWS ONLY
  ) TP ON BA.ISBN = TP.ISBN
ORDER BY
  TP.PURCHASECOUNT DESC,
  A.LNAME,
  A.FNAME;

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
  O.ORDER#,
  O.SHIPCITY,
  O.SHIPSTATE,
  (O.SHIPDATE - O.ORDERDATE) AS SHIPPINGDELAY
FROM
  ORDERS O
WHERE
  O.SHIPDATE IS NOT NULL
ORDER BY
  SHIPPINGDELAY DESC
FETCH FIRST
  1 ROW ONLY;

-- 8. Determine which customers placed orders for the least expensive book (in terms of regular retail price) carried by JustLee Books.
SELECT
  C.CUSTOMER#,
  C.LASTNAME,
  C.FIRSTNAME,
  O.ORDER#,
  B.TITLE AS BOOKTITLE,
  B.RETAIL AS RETAILPRICE
FROM
  CUSTOMERS C
  JOIN ORDERS O ON C.CUSTOMER# = O.CUSTOMER#
  JOIN ORDERITEMS OI ON O.ORDER# = OI.ORDER#
  JOIN BOOKS B ON OI.ISBN = B.ISBN
WHERE
  B.RETAIL = (
    SELECT
      MIN(RETAIL)
    FROM
      BOOKS
  )
ORDER BY
  B.RETAIL;

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
  B.ISBN,
  B.TITLE,
  B.PUBDATE,
  B.RETAIL,
  B.CATEGORY
FROM
  BOOKS B
WHERE
  B.PUBID = (
    SELECT
      PUBID
    FROM
      BOOKS
    WHERE
      ISBN = (
        SELECT
          ISBN
        FROM
          BOOKS_2
        WHERE
          TITLE = 'THE WOK WAY TO COOK'
      )
  );
