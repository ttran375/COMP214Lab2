-- 6. An INSERT statement is needed to support users adding a new appeal. Create an INSERT statement using substitution variables. Note that users will be entering dates in the format of a two-digit month, a two-digit day, and a four-digit year, such as “12 17 2009.” In addition, a sequence named APPEALS_ID_SEQ exists to supply values for the Appeal_ID column, and the default setting for the Status column should take effect (that is, the DEFAULT option on the column should be used). Test the statement by adding the following appeal: crime_ID ¼ 25344031, filing date ¼ 02 13 2009, and hearing date ¼ 02 27 2009.
DECLARE
  v_crime_id NUMBER := 25344031;
  v_filing_date VARCHAR2(10) := '02 13 2009';
  v_hearing_date VARCHAR2(10) := '02 27 2009';
BEGIN
  INSERT INTO Appeals (Appeal_ID, Crime_ID, Filing_Date, Hearing_Date, Status)
  VALUES (APPEALS_ID_SEQ.NEXTVAL, v_crime_id, TO_DATE(v_filing_date, 'MM DD YYYY'), TO_DATE(v_hearing_date, 'MM DD YYYY'), DEFAULT);
  COMMIT;
END;
/
