### Problem Explanation

You are given a table `Employee` with the following columns:
- `id`: Unique identifier for each employee.
- `salary`: The salary of the employee.

Your task is to find the second highest distinct salary from this table. If there is no second highest salary (for example, if there is only one distinct salary), you should return `NULL`.

### Example

#### Input:

**Employee table**:

```
| id | salary |
|----|--------|
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
```

#### Output:

```
| SecondHighestSalary |
|---------------------|
| 200                 |
```

In this case, the highest salary is 300 and the second highest distinct salary is 200.

### Solution Approach

To find the second highest distinct salary, you can use a two-step approach:

1. **Find the Highest Salary**:
   - Determine the maximum salary present in the table.

2. **Find the Second Highest Salary**:
   - Use the maximum salary from the first step to filter out salaries that are equal to this maximum.
   - From the remaining salaries, find the maximum value, which will be the second highest salary.

### SQL Query

Here’s the SQL query to achieve this:

```sql
SELECT 
    MAX(salary) AS SecondHighestSalary
FROM 
    Employee
WHERE 
    salary < (SELECT MAX(salary) FROM Employee);
```

### Explanation of the Query:

1. **Subquery (`SELECT MAX(salary) FROM Employee`)**:
   - This subquery finds the highest salary in the `Employee` table. 

2. **Main Query**:
   - `SELECT MAX(salary) AS SecondHighestSalary`:
     - This part of the query finds the maximum salary from the remaining salaries (those less than the highest salary found in the subquery).

   - `WHERE salary < (SELECT MAX(salary) FROM Employee)`:
     - Filters out the highest salary so that we are left with the remaining salaries.
     - The maximum of these remaining salaries will be the second highest distinct salary.

### Handling Edge Cases

- **If There is Only One Distinct Salary**:
  - The subquery returns the highest salary.
  - The `WHERE` clause will filter out this salary, leaving an empty set.
  - The `MAX(salary)` function on this empty set returns `NULL`.

- **If There are No Employees**:
  - The query still behaves correctly and returns `NULL` because the result of the subquery will be `NULL`, and the `MAX` function over an empty set yields `NULL`.

### Result Table

The result will have the column `SecondHighestSalary` which will contain:
- The second highest distinct salary if it exists.
- `NULL` if no such salary exists.

This approach ensures you get the correct result even if there are edge cases such as fewer distinct salaries or empty tables.