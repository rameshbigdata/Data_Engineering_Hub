To calculate the bonus for each employee based on the specified conditions, you can use a SQL query that checks whether the employee's ID is odd and their name does not start with 'M'. Here’s how you can write the query:

```sql
SELECT 
    employee_id, 
    CASE 
        WHEN employee_id % 2 = 1 AND name NOT LIKE 'M%' THEN salary 
        ELSE 0 
    END AS bonus
FROM 
    Employees
ORDER BY 
    employee_id;
```

### Explanation:

1. **SELECT employee_id**: We're selecting the employee ID to include in our output.
  
2. **CASE statement**:
   - `WHEN employee_id % 2 = 1 AND name NOT LIKE 'M%' THEN salary`: This checks if the employee ID is odd (`employee_id % 2 = 1`) and if the name does not start with 'M'. If both conditions are true, the bonus is set to the employee's salary.
   - `ELSE 0`: If either condition is not met, the bonus is set to 0.

3. **FROM Employees**: This specifies the table we are querying.

4. **ORDER BY employee_id**: Finally, the results are ordered by `employee_id`.

This query will give you the desired output, calculating the bonus based on the defined rules.