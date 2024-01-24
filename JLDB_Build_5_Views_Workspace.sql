-- # Lab Exercises Module 2 - Views
-- From: Joan Casteel. 2015. Oracle 12c: SQL, 3rd Edition.
-- Boston: Course Technology.
-- Chapter 13
-- To perform the following activities, refer to the tables in the JustLee Books
-- database.
-- 1. Create a view that lists the name and phone number of the contact person
-- at each publisher. Don’t include the publisher’s ID in the view. Name the
-- view CONTACT.
CREATE VIEW CONTACT AS
    SELECT
        NAME    AS PUBLISHER_NAME,
        CONTACT AS CONTACT_PERSON,
        PHONE   AS CONTACT_PHONE
    FROM
        PUBLISHER;

select * from CONTACT;

-- 2. Change the CONTACT view so that no users can accidentally perform DML
-- operations on the view.
CREATE VIEW CONTACT AS
    SELECT
        NAME    AS PUBLISHER_NAME,
        CONTACT AS CONTACT_PERSON,
        PHONE   AS CONTACT_PHONE
    FROM
        PUBLISHER WITH READ ONLY;

-- 3. Create a view called HOMEWORK13 that includes the columns named Col1 and
-- Col2 from the FIRSTATTEMPT table. Make sure the view is created even if the
-- FIRSTATTEMPT table doesn’t exist.
CREATE FORCE VIEW HOMEWORK13 AS
    SELECT
        COL1,
        COL2
    FROM
        FIRSTATTEMPT;

-- 4. Attempt to view the structure of the HOMEWORK13 view.
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    DATA_LENGTH
FROM
    ALL_TAB_COLUMNS
WHERE
    TABLE_NAME = 'HOMEWORK13';

-- 5. Create a view that lists the ISBN and title for each book in inventory
-- along with the name and phone number of the person to contact if the book
-- needs to be reordered. Name the view REORDERINFO.
CREATE VIEW REORDERINFO AS
    SELECT
        B.ISBN,
        B.TITLE,
        P.NAME  AS PUBLISHERNAME,
        P.PHONE AS PUBLISHERPHONE
    FROM
        BOOKS     B
        JOIN PUBLISHER P
        ON B.PUBID = P.PUBID;

-- 6. Try to change the name of a contact person in the REORDERINFO view to your
-- name. Was an error message displayed when performing this step? If so, what
-- was the cause of the error message?
UPDATE REORDERINFO
SET
    PUBLISHERNAME = 'YourName'
WHERE
    ISBN = '1059831198';

-- 7. Select one of the books in the REORDERINFO view and try to change its
-- ISBN. Was an error message displayed when performing this step? If so, what
-- was the cause of the error message?
UPDATE REORDERINFO
SET
    ISBN = 'NewISBN'
WHERE
    ISBN = '1059831198';

-- 8. Delete the record in the REORDERINFO view containing your name. (If you
-- weren’t able to perform #6 successfully, delete one of the contacts already
-- listed in the table.) Was an error message displayed when performing this
-- step? If so, what was the cause of the error message?
DELETE FROM REORDERINFO
WHERE
    PUBLISHERNAME = 'YourName'

-- 9. Issue a rollback command to undo any changes made with the preceding
-- DML operations.
ROLLBACK;

-- 10. Delete the REORDERINFO view.
DROP VIEW REORDERINFO;
