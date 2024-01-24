# Advanced Challenge

## Sequences

1. **CUSTOMER_SEQ**
   - **Sequence for**: CUSTOMERS.CUSTOMER#
   - **Rationale**: Assigns a unique customer number to each new customer.
   - **SQL Statement**:

     ```sql
     CREATE SEQUENCE CUSTOMER_SEQ START WITH 1000 INCREMENT BY 1;
     ```

   - **Usage in INSERT**:

     ```sql
     INSERT INTO CUSTOMERS VALUES (
       CUSTOMER_SEQ.NEXTVAL,
       'LASTNAME',
       'FIRSTNAME',
       'ADDRESS',
       'CITY',
       'STATE',
       'ZIP',
       REFERRED,
       'REGION',
       'EMAIL'
     );
     ```

2. **ORDER_SEQ**
   - **Sequence for**: ORDERS.ORDER#
   - **Rationale**: Generates unique order numbers for each new order.
   - **SQL Statement**:

     ```sql
     CREATE SEQUENCE ORDER_SEQ START WITH 1000 INCREMENT BY 1;
     ```

   - **Usage in INSERT**:

     ```sql
     INSERT INTO ORDERS VALUES (
       ORDER_SEQ.NEXTVAL,
       CUSTOMER#,
       ORDERDATE,
       SHIPDATE,
       'SHIPSTREET',
       'SHIPCITY',
       'SHIPSTATE',
       'SHIPZIP',
       SHIPCOST
     );
     ```

3. **BOOKS_SEQ**
   - **Sequence for**: BOOKS.ISBN
   - **Rationale**: Provides unique ISBN numbers for each new book.
   - **SQL Statement**:

     ```sql
     CREATE SEQUENCE BOOKS_SEQ START WITH 1000000000 INCREMENT BY 1;
     ```

   - **Usage in INSERT**:

     ```sql
     INSERT INTO BOOKS VALUES (
       BOOKS_SEQ.NEXTVAL,
       'TITLE',
       PUBDATE,
       PUBID,
       COST,
       RETAIL,
       DISCOUNT,
       'CATEGORY'
     );
     ```

## Indexes

1. **CUSTOMER_NAME_IDX**
   - **Index on**: CUSTOMERS.LASTNAME, CUSTOMERS.FIRSTNAME
   - **Rationale**: Improves the performance of queries that involve searching for customers by name.
   - **SQL Statement**:

     ```sql
     CREATE INDEX CUSTOMER_NAME_IDX ON CUSTOMERS(LASTNAME, FIRSTNAME);
     ```

2. **ORDER_DATE_IDX**
   - **Index on**: ORDERS.ORDERDATE
   - **Rationale**: Enhances the retrieval speed of orders based on order dates.
   - **SQL Statement**:

     ```sql
     CREATE INDEX ORDER_DATE_IDX ON ORDERS(ORDERDATE);
     ```

3. **BOOK_CATEGORY_IDX**
   - **Index on**: BOOKS.CATEGORY
   - **Rationale**: Speeds up queries that filter books based on categories.
   - **SQL Statement**:

     ```sql
     CREATE INDEX BOOK_CATEGORY_IDX ON BOOKS(CATEGORY);
     ```

## Drawbacks

1. **Sequence Overhead**:
   - **Issue**: The use of sequences can introduce contention in highly concurrent environments, affecting performance.
   - **Mitigation**: Consider adjusting the cache size and monitoring sequence usage.

2. **Index Maintenance Overhead**:
   - **Issue**: Indexes require maintenance during data modifications (inserts, updates, deletes), impacting write performance.
   - **Mitigation**: Regularly monitor and optimize index usage, and only create indexes that significantly improve query performance.

3. **Storage Space**:
   - **Issue**: Indexes consume additional storage space.
   - **Mitigation**: Regularly monitor database storage and allocate sufficient space; consider compressing indexes if supported.

Before implementing these changes, it's essential to thoroughly test them in a development environment to assess their impact on performance and validate their effectiveness in improving the desired functionality.
