-- 1. The head DBA has requested the creation of a sequence for the primary key 
-- columns of the Criminals and Crimes tables. After creating the sequences, add 
-- a new criminal named Johnny Capps to the Criminals table by using the correct 
-- sequence. (Use any values for the remainder of columns.) A crime needs to be 
-- added for the criminal, too. Add a row to the Crimes table, referencing the 
-- sequence value already generated for the Criminal_ID and using the correct 
-- sequence to generate the Crime_ID value. (Use any values for the remainder of 
-- columns).
CREATE TABLE
    Criminals (
        Criminal_ID NUMBER,
        FirstName VARCHAR2(50),
        LastName VARCHAR2(50),
        -- other columns
        CONSTRAINT Criminals_PK PRIMARY KEY (Criminal_ID)
    );

CREATE TABLE
    Crimes (
        Crime_ID NUMBER,
        Criminal_ID NUMBER,
        CrimeType VARCHAR2(50),
        -- other columns
        CONSTRAINT Crimes_PK PRIMARY KEY (Crime_ID),
        CONSTRAINT Crimes_FK FOREIGN KEY (Criminal_ID) REFERENCES Criminals (Criminal_ID)
    );

-- Creating sequences
CREATE SEQUENCE seq_criminals
START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE seq_crimes
START WITH 1 INCREMENT BY 1;

-- Adding a new criminal named Johnny Capps
INSERT INTO
    Criminals (Criminal_ID, FirstName, LastName)
VALUES
    (seq_criminals.NEXTVAL, 'Johnny', 'Capps');

-- Adding a crime for the criminal
INSERT INTO
    Crimes (Crime_ID, Criminal_ID, CrimeType)
VALUES
    (
        seq_crimes.NEXTVAL,
        seq_criminals.CURRVAL,
        'Burglary'
    );

-- 2. The last name, street, and phone number columns of the Criminals table are used quite often in the WHERE clause condition of queries. Create objects that might improve data retrieval for these queries.
-- Creating an index on the LastName column
CREATE INDEX idx_criminals_last_name ON Criminals (LastName);

-- Creating an index on the Street column
CREATE INDEX idx_criminals_street ON Criminals (Street);

-- Creating an index on the PhoneNumber column
CREATE INDEX idx_criminals_phone_number ON Criminals (PhoneNumber);

-- 3. Would a bitmap index be appropriate for any columns in the City Jail database (assuming the columns are used in search and/or sort operations)? If so, identify the columns and explain why a bitmap index is appropriate for them.
CREATE BITMAP INDEX idx_criminals_gender ON Criminals (Gender);

CREATE BITMAP INDEX idx_crimes_crime_type ON Crimes (CrimeType);

CREATE BITMAP INDEX idx_prison_cells_status ON PrisonCells (PrisonCellStatus);

-- 4. Would using the City Jail database be any easier with the creation of synonyms? Explain why or why not.
CREATE SYNONYM CriminalData FOR Criminals;

-- Querying the Criminals table
SELECT
    Criminal_ID,
    First_Name,
    Last_Name
FROM
    Criminals
WHERE
    Last_Name = 'Capps';

-- Querying using the Synonym
SELECT
    Criminal_ID,
    First_Name,
    Last_Name
FROM
    CriminalData
WHERE
    Last_Name = 'Capps';
