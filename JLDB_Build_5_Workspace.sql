-- # Lab Exercises Module 2 - Views

-- From: Joan Casteel. 2015. Oracle 12c: SQL, 3rd Edition.

-- Boston: Course Technology.

-- Chapter 13

-- To perform the following activities, refer to the tables in the JustLee Books database.
-- 1. Create a view that lists the name and phone number of the contact person at each publisher. Don’t include the publisher’s ID in the view. Name the view CONTACT.
-- 2. Change the CONTACT view so that no users can accidentally perform DML operations on the view.
-- 3. Create a view called HOMEWORK13 that includes the columns named Col1 and Col2 from the FIRSTATTEMPT table. Make sure the view is created even if the FIRSTATTEMPT table doesn’t exist.
-- 4. Attempt to view the structure of the HOMEWORK13 view.
-- 5. Create a view that lists the ISBN and title for each book in inventory along with the name and phone number of the person to contact if the book needs to be reordered. Name the view REORDERINFO.
-- 6. Try to change the name of a contact person in the REORDERINFO view to your name. Was an error message displayed when performing this step? If so, what was the cause of the error message?
-- 7. Select one of the books in the REORDERINFO view and try to change its ISBN. Was an error message displayed when performing this step? If so, what was the cause of the error message?
-- 8. Delete the record in the REORDERINFO view containing your name. (If you weren’t able to perform #6 successfully, delete one of the contacts already listed in the table.) Was an error message displayed when performing this step? If so, what was the cause of the error message?
-- 9. Issue a rollback command to undo any changes made with the preceding DML operations.
-- 10. Delete the REORDERINFO view.

-- # Lab Exercises Module 2 - Database Objects

-- From: Joan Casteel. 2015. Oracle 12c: SQL, 3rd Edition.

-- Boston: Course Technology.

-- Lab Exercises - Database Objects

-- To perform the following assignments, refer to the tables in the JustLee Books database.

-- 1. Create a sequence for populating the Customer# column of the CUSTOMERS table. When setting the start and increment values, keep in mind that data already exists in this table. The options should be set to not cycle the values and not cache any values, and no minimum or maximum values should be declared.
-- 2. Add a new customer row by using the sequence created in Question 1. The only data currently available for the customer is as follows:
-- 3. last name = Shoulders, first name = Frank, and zip = 23567.
-- 4. Create a sequence that generates integers starting with the value 5. Each value should be three less than the previous value generated. The lowest possible value should be 0, and the sequence shouldn’t be allowed to cycle. Name the sequence MY_FIRST_SEQ.
-- 5. Issue a SELECT statement that displays NEXTVAL for MY_FIRST_SEQ three times. Because the value isn’t being placed in a table, use the DUAL table in the FROM clause of the SELECT statement. What causes the error on the third SELECT?
-- 6. Change the setting of MY_FIRST_SEQ so that the minimum value that can be generated is -1000.
-- 7. Create a private synonym that enables you to reference the MY_FIRST_SEQ object as NUMGEN.
-- 8. Use a SELECT statement to view the CURRVAL of NUMGEN. Delete the NUMGEN synonym and MY_FIRST_SEQ.
-- 9. Create a bitmap index on the CUSTOMERS table to speed up queries that search for customers based on their state of residence. Verify that the index exists, and then delete the index.
-- 10. Create a B-tree index on the customer’s Lastname column. Verify that the index exists by querying the data dictionary. Remove the index from the database.
-- 11. Many queries search by the number of days to ship (number of days between the order and shipping dates). Create an index that might improve the performance of these queries.


-- **Advanced Challenge**

-- To perform the following activity, refer to the tables in the JustLee Books database. Using the training you have received and speculating on query needs, determine appropriate uses for indexes and sequences in the JustLee Books database. Assume all tables will grow quite large in the number of rows. Identify at least three sequences and three indexes that can address needed functionality for the JustLee Books database. In a memo to management, you should identify each sequence and index that you propose and the rationale supporting your suggestions. You should also state any drawbacks that might affect database performance if the changes are implemented.

-- # Case Study

-- The head DBA has requested the creation of a sequence for the primary key columns of the Criminals and Crimes tables. After creating the sequences, add a new criminal named Johnny Capps to the Criminals table by using the correct sequence. (Use any values for the remainder of columns.)
-- A crime needs to be added for the criminal, too. Add a row to the Crimes table, referencing the sequence value already generated for the Criminal_ID and using the correct sequence to generate the Crime_ID value. (Use any values for the remainder of columns).
-- The last name, street, and phone number columns of the Criminals table are used quite often in the WHERE clause condition of queries. Create objects that might improve data retrieval for these queries.
-- Would a bitmap index be appropriate for any columns in the City Jail database (assuming the columns are used in search and/or sort operations)? If so, identify the columns and explain why a bitmap index is appropriate for them.
-- Would using the City Jail database be any easier with the creation of synonyms? Explain why or why not.
