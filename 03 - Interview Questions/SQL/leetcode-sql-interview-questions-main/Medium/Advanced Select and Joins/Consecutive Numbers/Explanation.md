To find all numbers that appear at least three times consecutively in a SQL table, you can use window functions to compare each row with the previous rows. Here’s a breakdown of how the provided SQL query works and why it effectively solves the problem:

### Problem Breakdown

1. **Identify Consecutive Numbers**:
   - You need to find numbers that appear three or more times in a row. For instance, if a number appears as `1, 1, 1` in three consecutive rows, then `1` should be reported.

### Solution Explanation

Here’s the SQL query used to solve this:

```sql
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT num,
           LAG(num, 1) OVER (ORDER BY id) AS prev1,
           LAG(num, 2) OVER (ORDER BY id) AS prev2
    FROM Logs
) AS temp
WHERE num = prev1 AND num = prev2;
```

### Step-by-Step Breakdown

1. **Subquery with Window Functions**:
   - `LAG(num, 1) OVER (ORDER BY id) AS prev1`: This retrieves the value of the `num` column from the previous row.
   - `LAG(num, 2) OVER (ORDER BY id) AS prev2`: This retrieves the value of the `num` column from two rows before the current row.

   The `LAG()` function is used here to look back at the previous rows relative to the current row based on the `id` order.

2. **Filtering Consecutive Numbers**:
   - `WHERE num = prev1 AND num = prev2`: This condition checks if the current row's `num` value is the same as the values from the previous two rows. If true, it means the number appears at least three times consecutively.

3. **Distinct Results**:
   - `SELECT DISTINCT num AS ConsecutiveNums`: To ensure that each number is listed only once in the result, use `DISTINCT`.

### Example

Given the input table:

```sql
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
```

- For `num = 1` at rows `1, 2, 3`, `num` matches with both `prev1` and `prev2` (previous values).
- For `num = 2`, it doesn’t match at any point with both `prev1` and `prev2` consecutively.

The result of the query will be:

```sql
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
```

### Summary

The query efficiently identifies numbers that appear consecutively for at least three times by leveraging SQL window functions to compare each row with its preceding rows. This approach ensures that you get accurate results without needing to perform complex joins or subqueries.