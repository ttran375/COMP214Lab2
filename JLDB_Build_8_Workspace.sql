-- 1. List the book title and retail price for all books with a retail price 
-- lower than the average retail price of all books sold by JustLee Books.
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

-- 2. Determine which books cost less than the average cost of other books in 
-- the same category.
-- 3. Determine which orders were shipped to the same state as order 1014.
SELECT DISTINCT
  o.Order#
FROM
  Orders o
WHERE
  o.ShipState = (
    SELECT
      ShipState
    FROM
      Orders
    WHERE
      Order# = 1014
  )
  AND o.Order# <> 1014;

-- 1. Determine which orders had a higher total amount due than order 1008.
SELECT
  Order#
FROM
  Orders
WHERE
  TotalAmountDue > (
    SELECT
      TotalAmountDue
    FROM
      Orders
    WHERE
      Order# = 1008
  );

-- 1. Determine which author or authors wrote the books most frequently 
-- purchased by customers of JustLee Books.
SELECT
  Author,
  COUNT(*) AS PurchaseCount
FROM
  BookPurchases
  JOIN Books ON BookPurchases.BookID = Books.BookID
  JOIN Authors ON Books.AuthorID = Authors.AuthorID
WHERE
  BookPurchases.CustomerID IN (
    SELECT
      CustomerID
    FROM
      Customers
    WHERE
      Bookstore = 'JustLee Books'
  )
GROUP BY
  Author
ORDER BY
  PurchaseCount DESC LIMIT 1;

-- 1. List the title of all books in the same category as books previously 
-- purchased by customer 1007. Don’t include books this customer has already 
-- purchased.
SELECT DISTINCT
  Books.Title
FROM
  BookCategories
  JOIN Books ON BookCategories.BookID = Books.BookID
  JOIN (
    SELECT DISTINCT
      CategoryID
    FROM
      BookCategories
    WHERE
      BookID IN (
        SELECT
          BookID
        FROM
          BookPurchases
        WHERE
          CustomerID = 1007
      )
  ) AS CustomerCategories ON BookCategories.CategoryID = CustomerCategories.CategoryID
WHERE
  Books.BookID NOT IN (
    SELECT
      BookID
    FROM
      BookPurchases
    WHERE
      CustomerID = 1007
  );

-- 1. List the shipping city and state for the order that had the longest 
-- shipping delay.
SELECT
  Orders.ShippingCity,
  Orders.ShippingState
FROM
  Orders
WHERE
  Orders.ShippingDelay = (
    SELECT
      MAX(ShippingDelay)
    FROM
      Orders
  );

-- 1. Determine which customers placed orders for the least expensive book (in 
-- terms of regular retail price) carried by JustLee Books.
SELECT
  Customers.CustomerID,
  Customers.CustomerName,
  Orders.OrderID,
  OrderDetails.BookID,
  Books.Title,
  Books.RegularRetailPrice
FROM
  Customers
  JOIN Orders ON Customers.CustomerID = Orders.CustomerID
  JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
  JOIN Books ON OrderDetails.BookID = Books.BookID
WHERE
  Books.RegularRetailPrice = (
    SELECT
      MIN(RegularRetailPrice)
    FROM
      Books
    WHERE
      Books.Publisher = 'JustLee Books'
  );

-- 1. Determine the number of different customers who have placed an order for 
-- books written or cowritten by James Austin.
SELECT
  COUNT(DISTINCT Customers.CustomerID) AS NumberOfCustomers
FROM
  Customers
  JOIN Orders ON Customers.CustomerID = Orders.CustomerID
  JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
  JOIN Books ON OrderDetails.BookID = Books.BookID
WHERE
  'James Austin' IN (Books.Author1, Books.Author2);

-- 1. Determine which books were published by the publisher of The Wok Way to 
-- Cook.
SELECT DISTINCT
  Books.*
FROM
  Books
  JOIN Publishers ON Books.PublisherID = Publishers.PublisherID
WHERE
  Publishers.PublisherName = (
    SELECT
      Publishers.PublisherName
    FROM
      Books
      JOIN Publishers ON Books.PublisherID = Publishers.PublisherID
    WHERE
      Books.Title = 'The Wok Way to Cook'
  );
