-- 1. Produce a list of all customer names in which the first letter of the first and last names is in uppercase and the rest are in lowercase.
SELECT
    INITCAP(LastName) || ' ' || INITCAP(FirstName) AS CustomerName
FROM
    Customers;
