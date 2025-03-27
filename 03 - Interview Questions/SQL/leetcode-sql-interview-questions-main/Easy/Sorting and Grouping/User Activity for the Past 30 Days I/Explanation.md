### Problem Explanation

You are given a table named `Activity` that logs user activities on a social media platform. Each record in this table indicates:

- `user_id`: The identifier of the user.
- `session_id`: The identifier of the session.
- `activity_date`: The date on which the activity occurred.
- `activity_type`: The type of activity performed (e.g., `open_session`, `end_session`, `scroll_down`, `send_message`).

Your task is to calculate the number of unique users who were active on each day within a specified 30-day period that ends on `2019-07-27` (inclusive). A user is considered active on a given day if they performed at least one activity on that day.

### Solution Explanation

To solve this problem, you need to determine the count of unique active users for each day within the given date range. Here’s how you can achieve this:

1. **Filter the Activity Data**: Extract records where the activity date falls within the specified 30-day period (`2019-06-28` to `2019-07-27`). Ensure you only consider unique combinations of `user_id` and `activity_date` to avoid counting duplicates.

2. **Count Unique Users per Day**: Group the filtered records by `activity_date` and count the distinct `user_id` for each date. This gives you the number of unique users who were active on each day.

3. **Return the Results**: Output the results with columns for the day and the count of active users, ordered by the date.

Here is the SQL query to accomplish this:

```sql
WITH filtered_activity AS (
    SELECT DISTINCT user_id, activity_date
    FROM Activity
    WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
),
daily_active_users AS (
    SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
    FROM filtered_activity
    GROUP BY activity_date
)
SELECT day, active_users
FROM daily_active_users
ORDER BY day;
```

**Explanation of the Query**:

1. **CTE `filtered_activity`**:
   - `SELECT DISTINCT user_id, activity_date`: Selects unique combinations of `user_id` and `activity_date` to ensure that duplicates are removed.
   - `WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'`: Filters records to include only those within the 30-day period.

2. **CTE `daily_active_users`**:
   - `SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users`: Groups the filtered data by `activity_date` and counts the number of distinct `user_id` values for each date.
   - `GROUP BY activity_date`: Aggregates data to get the count of active users per day.

3. **Final `SELECT`**:
   - `SELECT day, active_users FROM daily_active_users ORDER BY day`: Retrieves the results and orders them by date to present the count of active users for each day in chronological order.

This query will give you a table of each day within the specified period and the number of unique users who were active on that day.