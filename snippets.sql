BEGIN
   FOR c IN (SELECT table_name FROM user_tables) LOOP
      EXECUTE IMMEDIATE ('DROP TABLE ' || c.table_name || ' CASCADE CONSTRAINTS');
   END LOOP;

   FOR c IN (SELECT sequence_name FROM user_sequences) LOOP
      EXECUTE IMMEDIATE ('DROP SEQUENCE ' || c.sequence_name);
   END LOOP;

   FOR c IN (SELECT object_name, object_type FROM user_objects WHERE object_type IN ('FUNCTION', 'PROCEDURE', 'PACKAGE')) LOOP
      EXECUTE IMMEDIATE ('DROP ' || c.object_type || ' ' || c.object_name);
   END LOOP;
END;
/

BEGIN
   FOR v IN (SELECT view_name FROM user_views) LOOP
      EXECUTE IMMEDIATE 'DROP VIEW ' || v.view_name;
   END LOOP;
END;
/

BEGIN
   FOR t IN (SELECT table_name FROM user_tables) LOOP
      DBMS_OUTPUT.PUT_LINE('Table Name: ' || t.table_name);
   END LOOP;
END;
/