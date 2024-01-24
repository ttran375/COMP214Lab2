```sql
CREATE SYNONYM CriminalData FOR Criminals;
```

Here's how synonyms could make querying easier:

**Without Synonym:**

```sql
-- Querying the Criminals table
SELECT Criminal_ID, First_Name, Last_Name
FROM Criminals
WHERE Last_Name = 'Capps';
```

**With Synonym:**

```sql
-- Querying using the Synonym
SELECT Criminal_ID, First_Name, Last_Name
FROM CriminalData
WHERE Last_Name = 'Capps';
```

In this simple example, using a synonym (`CriminalData`) allows you to abstract away the actual table name (`Criminals`). If the table name ever changes or if you have a long and complex table name, you only need to update the synonym, not all instances in your queries.
