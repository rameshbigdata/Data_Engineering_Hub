### Problem Explanation:

You are given a table `Person` with two columns:
- `id`: A unique integer ID for each person (primary key).
- `email`: A string representing an email address. Emails are all in lowercase, and there can be duplicates.

The goal is to **delete all duplicate emails**, but **keep only one record for each email**. Specifically, you want to retain the row with the **smallest `id`** for each duplicate email and delete the rest.

### Example:

#### Input:
The input `Person` table looks like this:
```
| id  | email            |
|-----|------------------|
| 1   | john@example.com |
| 2   | bob@example.com  |
| 3   | john@example.com |
  ```
#### Output:
The expected output is:
```
| id  | email            |
|-----|------------------|
| 1   | john@example.com |
| 2   | bob@example.com  |
```
### Explanation:

- The email `john@example.com` is repeated two times (with `id` values 1 and 3). 
- We keep the row with the smallest `id` (which is 1) and delete the row with `id` 3.
- The email `bob@example.com` is unique, so we keep that row as well.

### Solution Approach:

To solve this problem, we can use a **common table expression (CTE)** and the `ROW_NUMBER()` window function to assign a unique rank to each email based on their `id`. The rank will allow us to identify duplicates, and we can then delete all rows where the rank is greater than 1 (i.e., the duplicates).

### Steps:
1. **Use the `ROW_NUMBER()` function**:
   - For each email, assign a row number starting from 1, ordered by `id`. This will rank each email's row, with the lowest `id` getting rank 1.
   
2. **Delete rows with a row number greater than 1**:
   - Once the rows are ranked, we can delete all rows that have a rank greater than 1 for each email, keeping only the row with rank 1 (the smallest `id`).

### SQL Query:

```sql
WITH RankedEmails AS (
    SELECT
        id,
        email,
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
    FROM Person
)
DELETE FROM Person
WHERE id IN (
    SELECT id
    FROM RankedEmails
    WHERE rn > 1
);
```

### Explanation of the Query:

1. **WITH RankedEmails AS (...):**
   - We use a **common table expression (CTE)** to rank each email based on their `id`.
   - `ROW_NUMBER() OVER (PARTITION BY email ORDER BY id)`:
     - For each unique email, assign a row number starting from 1, based on the `id`.
     - `PARTITION BY email` ensures that the row numbers are computed separately for each email.
     - `ORDER BY id` ensures that the row with the smallest `id` gets the rank 1.
   - The result of this CTE will be a temporary table with `id`, `email`, and `rn` (row number).

2. **DELETE FROM Person WHERE id IN (...):**
   - We delete the rows from the `Person` table where the `id` exists in the list of IDs that have a row number (`rn`) greater than 1. These are the duplicate emails with higher IDs.

3. **WHERE rn > 1:**
   - In the subquery, we select the `id` values for which the row number is greater than 1 (i.e., the duplicate emails), so that we can delete those rows.

### Output:

For the input `Person` table:
```
| id  | email            |
|-----|------------------|
| 1   | john@example.com |
| 2   | bob@example.com  |
| 3   | john@example.com |
```
The output will be:
```
| id  | email            |
|-----|------------------|
| 1   | john@example.com |
| 2   | bob@example.com  |
```
This ensures that the row with the smallest `id` for each email is kept, and all duplicates are removed.