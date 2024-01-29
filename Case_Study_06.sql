-- 6. An INSERT statement is needed to support users adding a new appeal. Create an INSERT statement using substitution variables. Note that users will be entering dates in the format of a two-digit month, a two-digit day, and a four-digit year, such as “12 17 2009.” In addition, a sequence named APPEALS_ID_SEQ exists to supply values for the Appeal_ID column, and the default setting for the Status column should take effect (that is, the DEFAULT option on the column should be used). Test the statement by adding the following appeal: crime_ID ¼ 25344031, filing date ¼ 02 13 2009, and hearing date ¼ 02 27 2009.
SET
  SERVEROUTPUT ON ACCEPT crime_id CHAR DEFAULT 25344031 PROMPT 'Enter Crime_ID [Default: 25344031]: ' ACCEPT filing_date CHAR DEFAULT '02 13 2009' PROMPT 'Enter Filing_Date (MM DD YYYY) [Default: 02 13 2009]: ' ACCEPT hearing_date CHAR DEFAULT '02 27 2009' PROMPT 'Enter Hearing_Date (MM DD YYYY) [Default: 02 27 2009]: '
DECLARE V_CRIME_ID NUMBER := &CRIME_ID;

V_FILING_DATE DATE := TO_DATE('&filing_date', 'MM DD YYYY');

V_HEARING_DATE DATE := TO_DATE('&hearing_date', 'MM DD YYYY');

BEGIN
INSERT INTO
  APPEALS (APPEAL_ID, CRIME_ID, FILING_DATE, HEARING_DATE)
VALUES
  (
    APPEALS_ID_SEQ.NEXTVAL,
    V_CRIME_ID,
    V_FILING_DATE,
    V_HEARING_DATE
  );

DBMS_OUTPUT.PUT_LINE ('Appeal successfully added.');

EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE ('Error: ' || SQLERRM);

END;

/
