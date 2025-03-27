WITH FirstLogin AS (
    -- Step 1: Get the first login date for each player
    SELECT player_id, MIN(event_date) AS first_login_date
    FROM Activity
    GROUP BY player_id
),
ConsecutiveLogin AS (
    -- Step 2: Check if the player logged in the day after their first login date
    SELECT DISTINCT a.player_id
    FROM Activity a
    JOIN FirstLogin f
    ON a.player_id = f.player_id
    WHERE a.event_date = DATE_ADD(f.first_login_date, INTERVAL 1 DAY)
)
-- Step 3: Count the number of players who logged in consecutively and calculate the fraction
SELECT 
    ROUND(COUNT(DISTINCT c.player_id) / COUNT(DISTINCT f.player_id), 2) AS fraction
FROM 
    FirstLogin f
LEFT JOIN 
    ConsecutiveLogin c
ON f.player_id = c.player_id;
