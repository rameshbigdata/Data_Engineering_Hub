### Problem Explanation:

You are given a table called `Users` with the following columns:
- `user_id`: An integer representing a unique ID for each user (primary key).
- `name`: A string containing a user's name, which can consist of lowercase and uppercase characters.

The goal is to "fix" the formatting of the `name` column by ensuring that:
1. The first letter of each name is capitalized (uppercase).
2. All subsequent letters are in lowercase.

You need to return the result ordered by `user_id`, maintaining the correct formatting for the `name` column.

### Example:

#### Input:
The input table looks like this:

```
| user_id | name  |
|---------|-------|
| 1       | aLice |
| 2       | bOB   |
```

#### Output:
The expected output is:

```
| user_id | name  |
|---------|-------|
| 1       | Alice |
| 2       | Bob   |
```

### Solution Explanation:

To solve this problem, you need to adjust the casing of the `name` column so that only the first character is in uppercase, and the rest are in lowercase. Here's how we can do this in SQL:

1. **UPPER(SUBSTRING(name, 1, 1))**: 
   - This function converts the first character of the name to uppercase.
   - `SUBSTRING(name, 1, 1)` extracts the first character of the `name`.
   - `UPPER()` then converts it to uppercase.

2. **LOWER(SUBSTRING(name, 2))**: 
   - This function extracts the remaining characters of the `name` starting from the second character (`SUBSTRING(name, 2)`) and converts them to lowercase using the `LOWER()` function.

3. **CONCAT()**:
   - The `CONCAT()` function is used to join the uppercase first letter with the remaining lowercase letters to form the corrected name.

4. **ORDER BY user_id**:
   - We order the results by `user_id` to return the rows in ascending order of `user_id`.

### SQL Query:

```sql
SELECT 
    user_id, 
    CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM 
    Users
ORDER BY 
    user_id;
```

### Explanation of the Query:

- **SELECT**: We are selecting two columns:
  - `user_id`: The user ID.
  - `name`: The fixed version of the user's name, created by concatenating the uppercase first character with the lowercase version of the rest of the name.

- **FROM Users**: We are fetching the data from the `Users` table.

- **ORDER BY user_id**: The results are ordered by the `user_id` in ascending order.

### Output:

For the input table:

```
| user_id | name  |
|---------|-------|
| 1       | aLice |
| 2       | bOB   |
````

The output will be:

```
| user_id | name  |
|---------|-------|
| 1       | Alice |
| 2       | Bob   |
```