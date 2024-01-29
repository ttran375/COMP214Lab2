-- 10. Determine which books were published by the publisher of The Wok Way to Cook.
SELECT
  b.ISBN,
  b.Title,
  b.PubDate,
  b.Retail,
  b.Category
FROM
  Books b
WHERE
  b.PubID = (
    SELECT
      PubID
    FROM
      Books
    WHERE
      ISBN = (
        SELECT
          ISBN
        FROM
          Books_2
        WHERE
          Title = 'THE WOK WAY TO COOK'
      )
  );
