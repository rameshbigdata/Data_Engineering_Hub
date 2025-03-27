### Problem Explanation

You have a table named `MyNumbers` that contains integers which might have duplicates. Your goal is to find the largest number that appears exactly once in this table. If no number appears exactly once, you should return `null`.

### Solution Explanation

To solve this problem, follow these steps:

1. **Identify Single Numbers**: Determine which numbers appear exactly once in the table. This involves grouping by the number and counting occurrences.

2. **Find the Maximum Single Number**: From the set of single numbers, find the maximum value.

3. **Handle Cases with No Single Numbers**: If no number appears exactly once, ensure to return `null`.

Here’s how you can implement this solution using SQL:

```sql
WITH SingleNumbers AS (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
)
SELECT MAX(num) AS num
FROM SingleNumbers;
```

**Explanation of the Query**:

1. **CTE `SingleNumbers`**:
   - `SELECT num`: Selects the `num` column which will be processed further.
   - `FROM MyNumbers`: Specifies the table to query.
   - `GROUP BY num`: Groups the rows by each unique number.
   - `HAVING COUNT(*) = 1`: Filters the groups to include only those numbers that appear exactly once.

2. **Final `SELECT`**:
   - `SELECT MAX(num) AS num`: Finds the maximum value from the filtered single numbers.
   - If there are no single numbers, `MAX(num)` will return `null`.

This query first creates a Common Table Expression (CTE) `SingleNumbers` that contains only those numbers which are single. Then, it calculates the maximum of these single numbers. If there are no such single numbers, the `MAX` function will naturally return `null`.