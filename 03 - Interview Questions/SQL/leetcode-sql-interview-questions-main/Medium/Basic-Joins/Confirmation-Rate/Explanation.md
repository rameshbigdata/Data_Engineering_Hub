### Query Explanation:

1. **`SELECT s.user_id`**:
   - We're selecting the `user_id` from the `Signups` table (`s`) to get all the users who have signed up.

2. **`ROUND(COALESCE(...), 2) AS confirmation_rate`**:
   - We're calculating the confirmation rate for each user, rounding it to two decimal places.
   - **`COALESCE(..., 0)`** ensures that users who have no confirmation requests get a rate of 0.

3. **`SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END)`**:
   - This part counts the number of confirmed messages for each user (`c.action = 'confirmed'`).

4. **`NULLIF(COUNT(c.action), 0)`**:
   - This counts the total number of confirmation requests for each user. `NULLIF(COUNT(c.action), 0)` returns `NULL` if no confirmation requests exist (i.e., when `COUNT(c.action)` is `0`), which prevents division by zero.
   
5. **`LEFT JOIN Confirmations c ON s.user_id = c.user_id`**:
   - We use a `LEFT JOIN` to include all users from the `Signups` table, even if they have no confirmation requests in the `Confirmations` table.
   
6. **`GROUP BY s.user_id`**:
   - We're grouping by `user_id` to aggregate the confirmation rates per user.
