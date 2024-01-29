-- 7. Determine the length of data stored in the ISBN field of the BOOKS table. Make sure each different length value is displayed only once (not once for each book).
SELECT DISTINCT
    LENGTH(ISBN) AS ISBN_Length
FROM
    BOOKS;
