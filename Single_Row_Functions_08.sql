-- 8. Using today’s date, determine the age (in months) of each book that JustLee sells. Make sure only whole months are displayed; ignore any portions of months. Display the book title, publication date, current date, and age.
SELECT
    Title,
    PubDate AS PublicationDate,
    SYSDATE AS CurrentDate,
    FLOOR(MONTHS_BETWEEN(SYSDATE, PubDate)) AS AgeInMonths
FROM
    Books;
