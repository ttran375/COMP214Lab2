SELECT SUBSTR(FirstName, 1, 3) AS FirstThreeChars
FROM Customers;

SELECT ISBN, Title, LENGTH(Title) AS TitleLength
FROM Books;

SELECT Customer#, 
       FirstName, 
       LPAD(FirstName, 15, '*') AS PaddedFirstNameLeft,
       RPAD(FirstName, 15, '*') AS PaddedFirstNameRight
FROM Customers;

SELECT Customer#, LTRIM(Address, 'P.O. BOX') AS TrimmedAddress
FROM Customers;

SELECT Customer#, REPLACE(Address, 'P.O.', 'POST OFFICE') AS UpdatedAddress
FROM Customers;

SELECT CONCAT(FirstName, LastName) AS FullName
FROM Customers;


SELECT FirstName || ' ' || LastName || ', ' || City AS FullInfo
FROM Customers;

-- Example: Round the ShipCost in the Orders table to 2 decimal places
SELECT Order#, ROUND(ShipCost, 2) AS RoundedShipCost
FROM Orders;

-- Assuming you are using MySQL
SELECT ShipDate, OrderDate, DATEDIFF(ShipDate, OrderDate) AS Delay
FROM Orders;
WHERE order# = 1004;

SELECT ShipDate, OrderDate, (ShipDate - OrderDate) AS Delay
FROM Orders
WHERE order# = 1004;

-- Assuming your database system supports MONTHS_BETWEEN
SELECT ShipDate, OrderDate, MONTHS_BETWEEN(ShipDate, OrderDate) AS DelayInMonths
FROM Orders
WHERE Order# = 1004;

-- Assuming your database system supports MONTHS_BETWEEN and ROUND
SELECT
    ShipDate,
    OrderDate,
    ROUND(MONTHS_BETWEEN(ShipDate, OrderDate), 2) AS RoundedDelayInMonths
FROM
    Orders
WHERE
    Order# = 1004;

-- Assuming you are using Oracle SQL
SELECT
    ShipDate,
    OrderDate,
    ADD_MONTHS(OrderDate, 3) AS NewShipDateAfter3Months
FROM
    Orders
WHERE
    Order# = 1004;

