### Problem Statement

You have an `Employees` table with the following columns:
- `employee_id`: A unique identifier for each employee.
- `name`: The name of the employee.
- `reports_to`: The `employee_id` of the manager to whom this employee reports. If this value is `null`, it means the employee does not report to anyone (i.e., they are at the top of the hierarchy).
- `age`: The age of the employee.

The goal is to find out which employees are managers and gather the following details for each manager:
1. The number of direct reports (employees who report directly to this manager).
2. The average age of these direct reports, rounded to the nearest integer.

A manager is defined as an employee who has at least one direct report.

### Solution Explanation

To solve this problem, you can use SQL with the following approach:

1. **Join the Table with Itself**: 
   - You need to join the `Employees` table with itself to match managers with their direct reports.
   - The join condition will be `e.employee_id = r.reports_to`, where `e` represents the manager and `r` represents the report.

2. **Count Direct Reports**:
   - Use the `COUNT()` function to count the number of employees (reports) directly reporting to each manager.
   
3. **Calculate Average Age**:
   - Use the `AVG()` function to compute the average age of these direct reports.
   - Round this average using `ROUND()` to get the nearest integer.

4. **Filter Only Managers**:
   - Since we are interested in managers only, we will group by the `employee_id` and `name` of the manager and ensure that each manager has at least one report.
   
5. **Order the Results**:
   - Finally, sort the results by `employee_id` to meet the output requirements.

Here’s the SQL query that accomplishes this:

```sql
SELECT
    e.employee_id,
    e.name,
    COUNT(r.employee_id) AS reports_count,
    ROUND(AVG(r.age)) AS average_age
FROM
    Employees e
JOIN
    Employees r
ON
    e.employee_id = r.reports_to
GROUP BY
    e.employee_id, e.name
ORDER BY
    e.employee_id;
```

### Detailed Breakdown:

- `FROM Employees e JOIN Employees r ON e.employee_id = r.reports_to`: This joins the `Employees` table with itself where `e` represents managers and `r` represents their direct reports.

- `COUNT(r.employee_id) AS reports_count`: Counts the number of direct reports for each manager.

- `ROUND(AVG(r.age)) AS average_age`: Calculates the average age of the direct reports and rounds it to the nearest integer.

- `GROUP BY e.employee_id, e.name`: Groups the results by each manager to aggregate the count and average age of their reports.

- `ORDER BY e.employee_id`: Orders the results by the `employee_id` of the manager.

By following these steps, you can efficiently determine the required information about managers and their direct reports.