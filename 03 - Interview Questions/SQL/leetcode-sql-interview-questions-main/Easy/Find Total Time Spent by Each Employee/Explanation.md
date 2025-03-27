To solve the problem of calculating the total time spent by each employee on each day in the office, we can use an SQL query that sums up the time intervals for each employee on each day.

Here’s the SQL query that accomplishes this:

```sql
SELECT 
    event_day AS day,
    emp_id,
    SUM(out_time - in_time) AS total_time
FROM 
    Employees
GROUP BY 
    event_day, emp_id
ORDER BY 
    event_day, emp_id;
```

### Explanation:

1. **SELECT Statement**: We select the `event_day` as `day`, the `emp_id`, and the sum of the time spent in the office (`out_time - in_time`).

2. **SUM Function**: The `SUM(out_time - in_time)` calculates the total time for each entry/exit event of an employee on a particular day.

3. **GROUP BY Clause**: This clause groups the results by `event_day` and `emp_id`, ensuring that we get the total time spent for each employee on each day.

4. **ORDER BY Clause**: This orders the results by `event_day` and `emp_id`, making the output organized.

### Output Format:

The output will be in the format specified, showing each day, the corresponding employee ID, and their total time spent in the office for that day.

This query will efficiently calculate the required totals based on the entries in the `Employees` table.