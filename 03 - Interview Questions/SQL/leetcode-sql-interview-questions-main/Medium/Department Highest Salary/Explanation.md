### Problem Explanation:

We have two tables:
1. **Employee**: Contains details about employees, including their `id`, `name`, `salary`, and the `departmentId` they belong to.
2. **Department**: Contains details about departments, including their `id` and `name`.

We need to find employees who have the **highest salary** in each department. If multiple employees in the same department have the same highest salary, all those employees should be included in the result.

### Solution Explanation:

The solution can be broken down into the following steps:

1. **Join the Employee and Department tables**:
   We need to combine information from both tables. Specifically, we need the department name from the `Department` table and the employee details (name, salary) from the `Employee` table. This can be done using a `JOIN` operation between the two tables, matching the `departmentId` in the `Employee` table with the `id` in the `Department` table.

2. **Filter employees with the highest salary in each department**:
   For each department, we need to find the employee(s) who have the maximum salary. This can be achieved using a `WHERE` clause with a subquery:
   - The subquery finds the maximum salary for the corresponding department (`departmentId`).
   - The `WHERE` clause ensures that only employees who earn the maximum salary in their department are included in the result.

### Query Breakdown:

```sql
SELECT
    d.name AS Department,  -- Get the department name from the Department table
    e.name AS Employee,    -- Get the employee name from the Employee table
    e.salary AS Salary     -- Get the employee salary from the Employee table
FROM
    Employee e
JOIN
    Department d ON e.departmentId = d.id  -- Join Employee and Department tables based on departmentId
WHERE
    e.salary = (                           -- Filter only the employees who have the highest salary
        SELECT MAX(salary)                 -- Subquery to get the maximum salary
        FROM Employee                      -- From the Employee table
        WHERE departmentId = e.departmentId -- In the same department as the current employee
    );
```

### Explanation of SQL Parts:

1. **JOIN**: 
   - `JOIN Department d ON e.departmentId = d.id`: This combines the `Employee` table (`e`) with the `Department` table (`d`) using the `departmentId` column from `Employee` and the `id` column from `Department`. This allows us to get the name of the department for each employee.

2. **Subquery**:
   - `(SELECT MAX(salary) FROM Employee WHERE departmentId = e.departmentId)`: This subquery finds the maximum salary for each department. It works by looking at the `Employee` table and selecting the highest salary where the `departmentId` matches the current employee's `departmentId`.

3. **WHERE clause**:
   - `e.salary = (subquery)`: This condition filters the results so that only employees whose salary matches the maximum salary in their department (as determined by the subquery) are selected.

### Example Walkthrough:

Consider the given example:

**Employee Table**:
```
| id  | name  | salary | departmentId |
|-----|-------|--------|--------------|
| 1   | Joe   | 70000  | 1            |
| 2   | Jim   | 90000  | 1            |
| 3   | Henry | 80000  | 2            |
| 4   | Sam   | 60000  | 2            |
| 5   | Max   | 90000  | 1            |
```

**Department Table**:
```
| id  | name  |
|-----|-------|
| 1   | IT    |
| 2   | Sales |
```
For department "IT" (`departmentId = 1`), the highest salary is 90000. Both Jim and Max have this salary, so they both appear in the output. For department "Sales" (`departmentId = 2`), the highest salary is 80000, which is earned by Henry.

**Output**:
```
| Department | Employee | Salary |
|------------|----------|--------|
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
```
This solution ensures that all employees with the highest salary in their department are returned.