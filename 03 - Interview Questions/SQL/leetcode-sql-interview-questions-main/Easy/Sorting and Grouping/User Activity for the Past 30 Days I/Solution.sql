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
