### Updated Query:

```sql
SELECT em1.name
FROM Employee em1
JOIN Employee em2
ON em1.id = em2.managerId
GROUP BY em1.id, em1.name
HAVING COUNT(em2.id) >= 5;
```

### Explanation:

1. **`SELECT em1.name`**:
   - We select the name of the employee from `em1`, who is a manager.

2. **`FROM Employee em1 JOIN Employee em2 ON em1.id = em2.managerId`**:
   - We join the `Employee` table with itself, where `em1` represents the manager and `em2` represents the employee who reports to that manager (`em2.managerId = em1.id`).

3. **`GROUP BY em1.id, em1.name`**:
   - We group the results by the manager's ID and name to aggregate their direct reports.

4. **`HAVING COUNT(em2.id) >= 5`**:
   - The `HAVING` clause filters out managers who have fewer than 5 direct reports. We count `em2.id` to get the number of direct reports for each manager.

### Output:

For the provided input:

```
| id  | name  | department | managerId |
|-----|-------|------------|-----------|
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
```

John has 5 direct reports (Dan, James, Amy, Anne, and Ron), so the output will be:

```
| name  |
|-------|
| John  |
```