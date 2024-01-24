-- ## Advanced Challenge
-- To perform the following activity, refer to the tables in the JustLee Books 
-- database. Using the training you have received and speculating on query 
-- needs, determine appropriate uses for indexes and sequences in the JustLee 
-- Books database. Assume all tables will grow quite large in the number of 
-- rows. Identify at least three sequences and three indexes that can address 
-- needed functionality for the JustLee Books database. In a memo to 
-- management, you should identify each sequence and index that you propose and 
-- the rationale supporting your suggestions. You should also state any 
-- drawbacks that might affect database performance if the changes are 
-- implemented.
CREATE SEQUENCE CUSTOMER_SEQ START WITH 1000 INCREMENT BY 1;

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

CREATE SEQUENCE ORDER_SEQ START WITH 1000 INCREMENT BY 1;

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

CREATE SEQUENCE BOOKS_SEQ START WITH 1000000000 INCREMENT BY 1;

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

CREATE INDEX CUSTOMER_NAME_IDX ON CUSTOMERS(LASTNAME, FIRSTNAME);

CREATE INDEX ORDER_DATE_IDX ON ORDERS(ORDERDATE);

CREATE INDEX BOOK_CATEGORY_IDX ON BOOKS(CATEGORY);