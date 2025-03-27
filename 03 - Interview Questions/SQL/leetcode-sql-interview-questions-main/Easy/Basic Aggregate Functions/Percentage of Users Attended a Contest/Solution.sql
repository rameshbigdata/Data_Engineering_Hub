WITH total_users AS (
    SELECT COUNT(*) AS total_user_count
    FROM Users
),
contest_registration_count AS (
    SELECT contest_id, COUNT(DISTINCT user_id) AS registered_users
    FROM Register
    GROUP BY contest_id
)
SELECT r.contest_id, 
       ROUND((r.registered_users / t.total_user_count) * 100, 2) AS percentage
FROM contest_registration_count r
JOIN total_users t
ON 1=1
ORDER BY percentage DESC, contest_id ASC;
