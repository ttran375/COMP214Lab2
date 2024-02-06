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
