-- Drop all tables
BEGIN
  FOR cur IN (SELECT table_name FROM user_tables) LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || cur.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;

-- Drop all sequences
BEGIN
  FOR cur IN (SELECT sequence_name FROM user_sequences) LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || cur.sequence_name;
  END LOOP;
END;

-- Drop all other objects (views, triggers, etc.)
BEGIN
  FOR cur IN (SELECT object_name, object_type FROM user_objects WHERE object_type NOT IN ('TABLE', 'SEQUENCE')) LOOP
    EXECUTE IMMEDIATE 'DROP ' || cur.object_type || ' ' || cur.object_name;
  END LOOP;
END;

-- Commit the changes
COMMIT;
