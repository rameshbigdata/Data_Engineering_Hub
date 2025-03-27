You can achieve the swap of 'f' and 'm' values in the `sex` column with a single `UPDATE` statement using a `CASE` expression. Here’s how you can write that statement:

```sql
UPDATE Salary
SET sex = CASE 
             WHEN sex = 'm' THEN 'f' 
             WHEN sex = 'f' THEN 'm' 
          END;
```

This SQL command updates the `sex` column by changing 'm' to 'f' and 'f' to 'm' for all rows in the `Salary` table.