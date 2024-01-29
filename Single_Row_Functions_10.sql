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
