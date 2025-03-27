### Steps and SQL Solution:

1. **Rank Salaries Within Each Department:**
   - Use the `DENSE_RANK()` window function to rank salaries within each department. This function will assign a unique rank to each distinct salary value in descending order.

2. **Filter for Top Three Salaries:**
   - Filter the ranked results to include only those employees whose salaries fall within the top three ranks.

3. **Join with Department Information:**
   - Join the `Employee` table with the `Department` table to get the department names for each employee.

4. **Select and Order Results:**
   - Finally, select the relevant columns and order the results as needed.

### Detailed SQL Query:

```sql
WITH RankedSalaries AS (
    SELECT
        e.id,
        e.name,
        e.salary,
        e.departmentId,
        d.name AS departmentName,
        DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS salaryRank
    FROM
        Employee e
    JOIN
        Department d ON e.departmentId = d.id
),
TopSalaries AS (
    SELECT
        departmentName,
        name AS Employee,
        salary
    FROM
        RankedSalaries
    WHERE
        salaryRank <= 3
)
SELECT
    departmentName AS Department,
    Employee,
    salary AS Salary
FROM
    TopSalaries
ORDER BY
    Department,
    Salary DESC;
```

### Explanation:

1. **`RankedSalaries` CTE:**
   - This CTE calculates the rank of each salary within its department using `DENSE_RANK()`. The ranking is done in descending order, so the highest salary gets the rank of 1, the second highest gets 2, and so on.
   - The `PARTITION BY` clause ensures that the ranking is reset for each department.
   - We join `Employee` with `Department` to get the department names.

2. **`TopSalaries` CTE:**
   - This CTE filters the ranked results to include only those employees whose salary ranks are 1, 2, or 3. This means we only keep employees who are among the top three unique salaries in their respective departments.

3. **Final SELECT Query:**
   - Selects and renames the relevant columns to match the required output format.
   - Orders the results by `Department` and `Salary` in descending order to make it easy to read and analyze.

This query efficiently identifies high earners in each department, ensuring that the results include only those with the top three unique salaries.