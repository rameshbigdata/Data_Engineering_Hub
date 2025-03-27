# Breakdown of the Query

1. **FROM Project AS p**
   - This part of the query starts by selecting from the `Project` table and assigns it an alias `p` for easier reference.

2. **INNER JOIN Employee AS e ON p.employee_id = e.employee_id**
   - This performs an inner join between the `Project` table (`p`) and the `Employee` table (`e`). The join condition is that the `employee_id` in the `Project` table matches the `employee_id` in the `Employee` table.
   - The result of this join is a combined table that includes all columns from both the `Project` and `Employee` tables for the employees working on each project.

3. **SELECT p.project_id, ROUND(AVG(e.experience_years), 2) AS average_years**
   - This selects the `project_id` from the `Project` table and calculates the average of `experience_years` from the `Employee` table. The `ROUND()` function is used to round the average to 2 decimal places.
   - `AVG(e.experience_years)` calculates the average experience years for the employees working on each project.

4. **GROUP BY p.project_id**
   - This groups the results by `project_id`. This means that the average experience years will be calculated for each unique `project_id`.

### Example Walkthrough

Using the example data:

**Project Table:**
```
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
```

**Employee Table:**
```
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
```

**Process:**
- For `project_id = 1`, the employees are `1 (3 years)`, `2 (2 years)`, and `3 (1 year)`. The average experience is `(3 + 2 + 1) / 3 = 2.00`.
- For `project_id = 2`, the employees are `1 (3 years)` and `4 (2 years)`. The average experience is `(3 + 2) / 2 = 2.50`.

**Result:**
```
+-------------+---------------+
| project_id  | average_years |
+-------------+---------------+
| 1           | 2.00          |
| 2           | 2.50          |
+-------------+---------------+
```

This query effectively calculates and presents the average experience years of employees for each project, rounded to two decimal places.