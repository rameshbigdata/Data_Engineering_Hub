To determine which users have valid emails, we need to validate the email addresses based on specific criteria. Here’s a step-by-step breakdown of the solution:

### Criteria for a Valid Email:

1. **Domain Check**: The email must end with the domain `@leetcode.com`.
2. **Prefix Name**: The part before the domain (prefix name) must:
   - Start with a letter (either uppercase or lowercase).
   - Contain only letters, digits, underscores (`_`), periods (`.`), or dashes (`-`).

### Example:

For the given `Users` table:

```
| user_id | name      | mail                    |
|---------|-----------|-------------------------|
| 1       | Winston   | winston@leetcode.com    |
| 2       | Jonathan  | jonathanisgreat         |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
| 5       | Marwan    | quarz#2020@leetcode.com |
| 6       | David     | david69@gmail.com       |
| 7       | Shapiro   | .shapo@leetcode.com     |
```

### Valid Emails:
- `winston@leetcode.com` (Valid)
- `bella-@leetcode.com` (Valid)
- `sally.come@leetcode.com` (Valid)

### Invalid Emails:
- `jonathanisgreat` (Missing domain)
- `quarz#2020@leetcode.com` (Invalid character `#`)
- `david69@gmail.com` (Incorrect domain)
- `.shapo@leetcode.com` (Prefix starts with a period)

### Solution Approach:

1. **Domain Verification**:
   - Use `LIKE '%@leetcode.com'` to check that the email ends with `@leetcode.com`.

2. **Length Check**:
   - Ensure the email length is greater than the length of the domain part to ensure there is a prefix.

3. **Prefix Validation**:
   - Extract the prefix (the part before `@leetcode.com`) and use a regular expression to check:
     - Starts with a letter.
     - Contains only valid characters (`A-Za-z`, `0-9`, `_`, `.`, `-`).

### SQL Query:

Here's how you can construct the SQL query to filter valid emails:

```sql
SELECT 
    user_id, 
    name, 
    mail
FROM 
    Users
WHERE 
    mail LIKE '%@leetcode.com' 
    AND LENGTH(mail) > LENGTH('@leetcode.com')
    AND REGEXP_LIKE(
        SUBSTRING(mail, 1, LENGTH(mail) - LENGTH('@leetcode.com')), 
        '^[A-Za-z][A-Za-z0-9_.-]*$'
    );
```

### Explanation of the Query:

1. **SELECT user_id, name, mail**:
   - Retrieves the user ID, name, and email for each user.

2. **FROM Users**:
   - Specifies the table from which to select data.

3. **WHERE mail LIKE '%@leetcode.com'**:
   - Filters emails that end with `@leetcode.com`.

4. **AND LENGTH(mail) > LENGTH('@leetcode.com')**:
   - Ensures the email is longer than just the domain part, which means there’s a valid prefix.

5. **AND REGEXP_LIKE(SUBSTRING(mail, 1, LENGTH(mail) - LENGTH('@leetcode.com')), '^[A-Za-z][A-Za-z0-9_.-]*$')**:
   - Extracts the prefix by removing the domain part and checks:
     - The prefix starts with a letter (`^[A-Za-z]`).
     - Contains only valid characters (`[A-Za-z0-9_.-]*`).

This query will give you a list of users with valid emails based on the specified criteria.