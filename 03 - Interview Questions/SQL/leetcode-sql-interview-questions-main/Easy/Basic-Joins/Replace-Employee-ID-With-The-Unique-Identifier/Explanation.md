### Problem Breakdown

1. **Tables Involved:**
   - **Employees:** Contains details about employees, with `id` as a unique identifier and `name` as the employee's name.
   - **EmployeeUNI:** Contains unique IDs assigned to employees, with `id` as a reference to the employee and `unique_id` as the unique identifier.

2. **Objective:**
   - Show each employee's name and their corresponding unique ID.
   - If an employee does not have a unique ID, show `NULL` instead.

### SQL Query Explanation

```sql
SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees
LEFT JOIN EmployeeUNI ON Employees.id = EmployeeUNI.id;
```

#### Components of the Query

1. **SELECT Clause:**
   - `EmployeeUNI.unique_id`: This selects the `unique_id` from the `EmployeeUNI` table. If an employee does not have a unique ID, this field will show `NULL`.
   - `Employees.name`: This selects the `name` from the `Employees` table.

2. **FROM Clause:**
   - `Employees`: The query starts with the `Employees` table, which is the primary table we want to display data from.

3. **LEFT JOIN Clause:**
   - `LEFT JOIN EmployeeUNI ON Employees.id = EmployeeUNI.id`: This part performs a left join operation between the `Employees` table and the `EmployeeUNI` table.
     - **LEFT JOIN** ensures that all rows from the `Employees` table are included in the result set, regardless of whether a matching row exists in the `EmployeeUNI` table.
     - `Employees.id = EmployeeUNI.id`: This condition specifies how to match rows between the two tables—by the employee's `id`.

#### How It Works

- **Matching Rows:**
  - For each employee in the `Employees` table, the query tries to find a corresponding row in the `EmployeeUNI` table using the `id` column.
  - If a match is found, the `unique_id` from `EmployeeUNI` is included in the result set.
  - If no match is found (meaning the employee does not have a unique ID), `unique_id` will be `NULL`.

- **Output:**
  - The result will contain the `unique_id` and `name` for each employee.
  - Employees without a unique ID will have `NULL` in the `unique_id` column.

### Example

Given the input tables:

**Employees Table:**

```
| id | name     |
|----|----------|
| 1  | Alice    |
| 7  | Bob      |
| 11 | Meir     |
| 90 | Winston  |
| 3  | Jonathan |
```

**EmployeeUNI Table:**

```
| id | unique_id |
|----|-----------|
| 3  | 1         |
| 11 | 2         |
| 90 | 3         |
```

The query will return:

```
| unique_id | name     |
|-----------|----------|
| NULL      | Alice    |
| NULL      | Bob      |
| 2         | Meir     |
| 3         | Winston  |
| 1         | Jonathan |
```

Here:
- Alice and Bob don't have a corresponding `unique_id` in `EmployeeUNI`, so `NULL` is shown.
- Meir, Winston, and Jonathan have unique IDs, which are displayed next to their names.
