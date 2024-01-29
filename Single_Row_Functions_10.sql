-- 10. Produce a list of each customer number and the third and fourth digits of his or her zip code. The query should also display the position of the first occurrence of a 3 in the customer number, if it exists.
SELECT
    Customer#,
    SUBSTR(Zip, 3, 2) AS ThirdAndFourthDigitsOfZip,
    CASE
        WHEN INSTR(TO_CHAR(Customer#), '3') > 0 THEN INSTR(TO_CHAR(Customer#), '3')
        ELSE NULL
    END AS PositionOfFirst3
FROM
    Customers;

-- ### Advanced Challenge
-- Management is proposing to increase the price of each book. The amount of the increase will be based on each book’s category, according to the following scale: Computer books, 10%; Fitness books, 15%; Self-Help books, 25%; all other categories, 3%. Create a list that displays each book’s title, category, current retail price, and revised retail price. The prices should be displayed with two decimal places. The column headings for the output should be as follows: Title, Category, Current Price, and Revised Price. Sort the results by category. If there’s more than one book in a category, a secondary sort should be performed on the book’s title. Create a document to show management the SELECT statement used to generate the results and the results of the statement.
SELECT
    Title,
    Category,
    TO_CHAR(Retail, '$9999.99') AS "Current Price",
    TO_CHAR(
        Retail * CASE
            WHEN Category = 'Computer' THEN 1.10
            WHEN Category = 'Fitness' THEN 1.15
            WHEN Category = 'Self Help' THEN 1.25
            ELSE 1.03
        END,
        '$9999.99'
    ) AS "Revised Price"
FROM
    Books
ORDER BY
    Category,
    Title;
