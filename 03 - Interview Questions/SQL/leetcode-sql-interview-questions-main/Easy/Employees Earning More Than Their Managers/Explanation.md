To solve the problem of finding employees who earn more than their managers, we can use a **self-join** on the `Employee` table. A self-join is a join where a table is joined with itself.

### Steps:
1. We will alias the `Employee` table as `e1` for the employees.
2. We will alias the `Employee` table again as `e2` for the managers.
3. We'll join the two tables where the `e1.managerId` matches the `e2.id` (i.e., the employee's manager's ID matches the manager's employee ID).
4. Finally, we'll add a condition to check if `e1.salary > e2.salary` (i.e., the employee earns more than their manager).

### SQL Query:

```sql
SELECT e1.name AS Employee
FROM Employee e1
JOIN Employee e2 ON e1.managerId = e2.id
WHERE e1.salary > e2.salary;
```

### Explanation:
- `e1` represents the employees.
- `e2` represents the managers.
- We perform an inner join on the condition `e1.managerId = e2.id` to match each employee with their manager.
- We then filter the results where the employee's salary (`e1.salary`) is greater than their manager's salary (`e2.salary`).
- Finally, we select the `name` of the employee who meets this condition.

### Example:
For the input:

```
| id  | name  | salary | managerId |
|-----|-------|--------|-----------|
| 1   | Joe   | 70000  | 3         |
| 2   | Henry | 80000  | 4         |
| 3   | Sam   | 60000  | Null      |
| 4   | Max   | 90000  | Null      |
```

- Joe earns 70,000, and his manager (Sam) earns 60,000. Since Joe earns more than Sam, Joe should be in the result.
- Henry earns 80,000, and his manager (Max) earns 90,000. Since Henry earns less than Max, he shouldn't be in the result.

The output will be:

```
| Employee |
|----------|
| Joe      |
```