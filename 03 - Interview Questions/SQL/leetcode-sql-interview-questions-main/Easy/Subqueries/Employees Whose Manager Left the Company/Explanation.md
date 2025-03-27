### Problem Statement Breakdown:

You have an `Employees` table with the following columns:

1. `employee_id`: The unique ID of each employee (primary key).
2. `name`: The name of the employee.
3. `manager_id`: The ID of the employee's manager (if the employee has one; otherwise, it’s `null`).
4. `salary`: The salary of the employee.

Some employees do not have managers (those with `manager_id` set to `null`), and when a manager leaves the company, their information is deleted from the table. However, the `manager_id` for their former subordinates remains in the table, even though their manager no longer exists.

### Objective:

You need to find the IDs of the employees who meet **both** of the following conditions:

1. Their salary is less than $30,000.
2. Their manager has left the company (which is indicated by the fact that there is no record for their manager in the `Employees` table).

The result should return the IDs of these employees ordered by `employee_id`.

### Example:

#### Input:

```sql
+-------------+-----------+------------+--------+
| employee_id | name      | manager_id | salary |
+-------------+-----------+------------+--------+
| 3           | Mila      | 9          | 60301  |
| 12          | Antonella | null       | 31000  |
| 13          | Emery     | null       | 67084  |
| 1           | Kalel     | 11         | 21241  |
| 9           | Mikaela   | null       | 50937  |
| 11          | Joziah    | 6          | 28485  |
+-------------+-----------+------------+--------+
```

From this table:

- Employees with salaries below $30,000: `1 (Kalel)` and `11 (Joziah)`.
- `Kalel's manager_id = 11`, and `Joziah's manager_id = 6`.
- There is no record for manager `6` in the table, so Joziah’s manager has left the company.
  
Thus, only `Joziah (employee_id = 11)` meets both criteria.

#### Output:

```sql
+-------------+
| employee_id |
+-------------+
| 11          |
+-------------+
```

### SQL Solution:

Here’s how the solution works:

```sql
SELECT e.employee_id
FROM Employees e
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM Employees m
    WHERE m.employee_id = e.manager_id
  )
ORDER BY e.employee_id;
```

### Explanation of the SQL Query:

1. **`SELECT e.employee_id`**: We want to retrieve the `employee_id` of the employees who meet the conditions.

2. **`FROM Employees e`**: We're querying the `Employees` table, aliasing it as `e` for easy reference.

3. **`WHERE e.salary < 30000`**: This ensures that only employees whose salary is below $30,000 are considered.

4. **`AND e.manager_id IS NOT NULL`**: This condition filters out employees who do not have a manager. We only care about employees who have a manager.

5. **`AND NOT EXISTS (SELECT 1 FROM Employees m WHERE m.employee_id = e.manager_id)`**: This subquery checks if the employee’s manager exists in the `Employees` table. If the manager cannot be found (i.e., the subquery returns no result), it means the manager has left the company. The `NOT EXISTS` ensures that we only return employees whose managers no longer exist.

6. **`ORDER BY e.employee_id`**: The results are sorted by `employee_id` in ascending order as requested.

### Key Points:

- **Subquery (`NOT EXISTS`)**: The subquery is crucial because it checks whether the manager of the employee is still in the `Employees` table. If the manager doesn't exist in the table, the `NOT EXISTS` clause evaluates to true.
- **Manager Left**: We can infer that the manager has left when their `employee_id` is not found in the table. 
