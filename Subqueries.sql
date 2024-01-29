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
  A.AuthorID,
  A.Lname,
  A.Fname,
  (
    SELECT
      COUNT(*)
    FROM
      OrderItems OI
    WHERE
      OI.ISBN IN (
        SELECT
          BA.ISBN
        FROM
          BookAuthor BA
        WHERE
          BA.AuthorID = A.AuthorID
      )
  ) AS PurchaseCount
FROM
  Author A
ORDER BY
  PurchaseCount DESC
FETCH FIRST
  1 ROW ONLY;

-- 6. List the title of all books in the same category as books previously purchased by customer 1007. Don’t include books this customer has already purchased.
-- List titles of books in the same category as books purchased by customer 1007
SELECT DISTINCT
  b.Title
FROM
  Orders o,
  OrderItems oi,
  Books b
WHERE
  o.Order# = oi.Order#
  AND oi.ISBN = b.ISBN
  AND b.Category IN (
    SELECT DISTINCT
      b.Category
    FROM
      Orders o,
      OrderItems oi,
      Books b
    WHERE
      o.Order# = oi.Order#
      AND oi.ISBN = b.ISBN
      AND o.Customer# = 1007
  )
  AND b.ISBN NOT IN (
    SELECT
      ISBN
    FROM
      OrderItems
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

SELECT
  title
FROM
  books
WHERE
  category IN (
    SELECT DISTINCT
      category
    FROM
      books
      JOIN orderitems USING (isbn)
      JOIN orders USING (order#)
    WHERE
      customer# = 1007
  )
  AND isbn NOT IN (
    SELECT
      isbn
    FROM
      orders
      JOIN orderitems USING (order#)
    WHERE
      customer# = 1007
  );

-- 7. List the shipping city and state for the order that had the longest shipping delay.
SELECT
  Order#,
  ShipCity,
  ShipState,
  ShipDate - OrderDate AS ShippingDelay
FROM
  Orders
WHERE
  ShipDate IS NOT NULL
ORDER BY
  ShippingDelay DESC
FETCH FIRST
  1 ROWS ONLY;

-- 8. Determine which customers placed orders for the least expensive book (in terms of regular retail price) carried by JustLee Books.
SELECT DISTINCT
  c.Customer#,
  c.FirstName,
  c.LastName,
  o.Order#
FROM
  Customers c
  JOIN Orders o ON c.Customer# = o.Customer#
  JOIN OrderItems oi ON o.Order# = oi.Order#
  JOIN Books b ON oi.ISBN = b.ISBN
ORDER BY
  b.Retail
FETCH FIRST
  1 ROWS ONLY;

-- 9. Determine the number of different customers who have placed an order for books written or cowritten by James Austin.
SELECT
  COUNT(DISTINCT c.Customer#) AS NumberOfCustomers
FROM
  Customers c
  JOIN Orders o ON c.Customer# = o.Customer#
  JOIN OrderItems oi ON o.Order# = oi.Order#
  JOIN BookAuthor ba ON oi.ISBN = ba.ISBN
  JOIN Author a ON ba.AuthorID = a.AuthorID
WHERE
  a.Lname = 'AUSTIN'
  AND a.Fname = 'JAMES';

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
