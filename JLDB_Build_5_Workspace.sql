-- # Lab Exercises Module 2 - Views

-- From: Joan Casteel. 2015. Oracle 12c: SQL, 3rd Edition.

-- Boston: Course Technology.

-- Chapter 13

-- To perform the following activities, refer to the tables in the JustLee Books database.

-- 1. Create a view that lists the name and phone number of the contact person at each publisher. Don’t include the publisher’s ID in the view. Name the view CONTACT.
CREATE VIEW CONTACT AS
    SELECT
        NAME    AS PUBLISHER_NAME,
        CONTACT AS CONTACT_PERSON,
        PHONE   AS CONTACT_PHONE
    FROM
        PUBLISHER;

-- 2. Change the CONTACT view so that no users can accidentally perform DML operations on the view.
CREATE VIEW CONTACT AS
    SELECT
        NAME    AS PUBLISHER_NAME,
        CONTACT AS CONTACT_PERSON,
        PHONE   AS CONTACT_PHONE
    FROM
        PUBLISHER WITH READ ONLY;

-- 3. Create a view called HOMEWORK13 that includes the columns named Col1 and Col2 from the FIRSTATTEMPT table. Make sure the view is created even if the FIRSTATTEMPT table doesn’t exist.
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

-- 5. Create a view that lists the ISBN and title for each book in inventory along with the name and phone number of the person to contact if the book needs to be reordered. Name the view REORDERINFO.
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

-- 6. Try to change the name of a contact person in the REORDERINFO view to your name. Was an error message displayed when performing this step? If so, what was the cause of the error message?
UPDATE REORDERINFO
SET
    PUBLISHERNAME = 'YourName'
WHERE
    ISBN = '1059831198';

-- 7. Select one of the books in the REORDERINFO view and try to change its ISBN. Was an error message displayed when performing this step? If so, what was the cause of the error message?
UPDATE REORDERINFO
SET
    ISBN = 'NewISBN'
WHERE
    ISBN = '1059831198';

-- 8. Delete the record in the REORDERINFO view containing your name. (If you weren’t able to perform #6 successfully, delete one of the contacts already listed in the table.) Was an error message displayed when performing this step? If so, what was the cause of the error message?
DELETE FROM REORDERINFO
WHERE
    PUBLISHERNAME = 'YourName' 
    

-- 9. Issue a rollback command to undo any changes made with the preceding DML operations.
ROLLBACK;

-- 10. Delete the REORDERINFO view.
DROP VIEW REORDERINFO;

-- # Lab Exercises Module 2 - Database Objects

-- From: Joan Casteel. 2015. Oracle 12c: SQL, 3rd Edition.

-- Boston: Course Technology.

-- Lab Exercises - Database Objects

-- To perform the following assignments, refer to the tables in the JustLee Books database.

-- 1. Create a sequence for populating the Customer# column of the CUSTOMERS table. When setting the start and increment values, keep in mind that data already exists in this table. The options should be set to not cycle the values and not cache any values, and no minimum or maximum values should be declared.
CREATE SEQUENCE customer_seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE
  NOCYCLE
  NOCACHE;

-- 2. Add a new customer row by using the sequence created in Question 1. The only data currently available for the customer is as follows:
-- 2. last name = Shoulders, first name = Frank, and zip = 23567.
INSERT INTO CUSTOMERS (Customer#, LastName, FirstName, Zip)
VALUES (customer_seq.NEXTVAL, 'Shoulders', 'Frank', '23567');

-- 3. Create a sequence that generates integers starting with the value 5. Each value should be three less than the previous value generated. The lowest possible value should be 0, and the sequence shouldn’t be allowed to cycle. Name the sequence MY_FIRST_SEQ.
-- CREATE SEQUENCE my_first_seq
--   START WITH 5
--   INCREMENT BY -3
--   MINVALUE 0
--   NOCYCLE
--   NOCACHE;

-- 4. Issue a SELECT statement that displays NEXTVAL for MY_FIRST_SEQ three times. Because the value isn’t being placed in a table, use the DUAL table in the FROM clause of the SELECT statement. What causes the error on the third SELECT?
SELECT my_first_seq.NEXTVAL FROM DUAL;
SELECT my_first_seq.NEXTVAL FROM DUAL;
SELECT my_first_seq.NEXTVAL FROM DUAL; -- Causes an error

-- 5. Change the setting of MY_FIRST_SEQ so that the minimum value that can be generated is -1000.
ALTER SEQUENCE my_first_seq MINVALUE -1000;

-- 6. Create a private synonym that enables you to reference the MY_FIRST_SEQ object as NUMGEN.
CREATE SYNONYM numgen FOR my_first_seq;

-- 7. Use a SELECT statement to view the CURRVAL of NUMGEN.
SELECT numgen.CURRVAL FROM DUAL;

-- 7. Delete the NUMGEN synonym and MY_FIRST_SEQ.
DROP SYNONYM numgen;
DROP SEQUENCE my_first_seq;

-- 8. Create a bitmap index on the CUSTOMERS table to speed up queries that search for customers based on their state of residence.
CREATE BITMAP INDEX idx_customers_state ON CUSTOMERS(State);

-- 8. Verify that the index exists,
SELECT index_name FROM user_indexes;

-- 8. and then delete the index.
DROP INDEX idx_customers_state;

-- 9. Create a B-tree index on the customer’s Lastname column.
CREATE INDEX idx_customers_lastname ON CUSTOMERS(LastName);

-- 9. Verify that the index exists by querying the data dictionary.
SELECT index_name FROM user_indexes;

-- 9. Remove the index from the database.
DROP INDEX idx_customers_lastname;

-- 10. Create an index for the number of days to ship.
-- Assuming you have an ORDERS table with OrderDate and ShipDate columns.
CREATE INDEX idx_days_to_ship ON ORDERS(ShipDate - OrderDate);

-- **Advanced Challenge**

-- To perform the following activity, refer to the tables in the JustLee Books database. Using the training you have received and speculating on query needs, determine appropriate uses for indexes and sequences in the JustLee Books database. Assume all tables will grow quite large in the number of rows. Identify at least three sequences and three indexes that can address needed functionality for the JustLee Books database. In a memo to management, you should identify each sequence and index that you propose and the rationale supporting your suggestions. You should also state any drawbacks that might affect database performance if the changes are implemented.

-- # Case Study

-- The head DBA has requested the creation of a sequence for the primary key columns of the Criminals and Crimes tables. After creating the sequences, add a new criminal named Johnny Capps to the Criminals table by using the correct sequence. (Use any values for the remainder of columns.) A crime needs to be added for the criminal, too. Add a row to the Crimes table, referencing the sequence value already generated for the Criminal_ID and using the correct sequence to generate the Crime_ID value. (Use any values for the remainder of columns). The last name, street, and phone number columns of the Criminals table are used quite often in the WHERE clause condition of queries. Create objects that might improve data retrieval for these queries. Would a bitmap index be appropriate for any columns in the City Jail database (assuming the columns are used in search and/or sort operations)? If so, identify the columns and explain why a bitmap index is appropriate for them. Would using the City Jail database be any easier with the creation of synonyms? Explain why or why not.

-- -- 1. Create sequences for the primary key columns of the Criminals and Crimes tables.
CREATE SEQUENCE criminals_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;
CREATE SEQUENCE crimes_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

-- -- 2. Add a new criminal named Johnny Capps to the Criminals table using the sequence.
-- INSERT INTO Criminals (Criminal_ID, Last_Name, First_Name, Street, Phone)
-- VALUES (criminals_seq.NEXTVAL, 'Capps', 'Johnny', '123 Main St', '555-1234');

-- -- 3. Add a crime for the criminal to the Crimes table using the generated sequence values.
-- INSERT INTO Crimes (Crime_ID, Criminal_ID, Crime_Type, Crime_Date)
-- VALUES (crimes_seq.NEXTVAL, criminals_seq.CURRVAL, 'Robbery', SYSDATE);

-- -- 4. Create indexes for columns frequently used in WHERE clause conditions.
-- CREATE INDEX idx_criminals_last_name ON Criminals(Last_Name);
-- CREATE INDEX idx_criminals_street ON Criminals(Street);
-- CREATE INDEX idx_criminals_phone ON Criminals(Phone);

-- -- 5. Determine if a bitmap index is appropriate for any columns in the City Jail database.
-- -- Bitmap indexes are suitable for low cardinality columns, like gender or crime type.
-- -- Assuming Crime_Type is low cardinality, you might create a bitmap index:
-- CREATE BITMAP INDEX idx_crimes_crime_type ON Crimes(Crime_Type);

-- -- 6. Determine if synonyms would make using the City Jail database easier.
-- -- Synonyms can provide abstraction and simplify queries if table or view names change.
-- -- If there are frequent changes to table/view names, synonyms might be helpful.
-- -- Example of creating synonyms:
-- CREATE SYNONYM cj_criminals FOR Criminals;
-- CREATE SYNONYM cj_crimes FOR Crimes;
-- -- Queries can then use cj_criminals and cj_crimes instead of Criminals and Crimes.

-- -- Note: Adjust column names and table names based on your actual database schema.

-- CREATE VIEW CONTACT AS
--     SELECT
--         NAME    AS PUBLISHERNAME,
--         CONTACT AS CONTACTPERSON,
--         PHONE   AS CONTACTPHONE
--     FROM
--         PUBLISHER;

-- REVOKE ALL ON CONTACT FROM PUBLIC;

-- CREATE FORCE VIEW HOMEWORK13 AS
--     SELECT
--         COL1,
--         COL2
--     FROM
--         FIRSTATTEMPT;

-- SELECT
--     *
-- FROM
--     USER_TAB_COLUMNS
-- WHERE
--     TABLE_NAME = 'HOMEWORK13';



