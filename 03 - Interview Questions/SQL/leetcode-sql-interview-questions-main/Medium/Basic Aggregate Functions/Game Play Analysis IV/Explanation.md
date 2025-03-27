### 1. `FirstLogin` CTE

**Purpose**: Identify the first login date for each player.

```sql
WITH FirstLogin AS (
    SELECT player_id, MIN(event_date) AS first_login_date
    FROM Activity
    GROUP BY player_id
)
```

- **`SELECT player_id, MIN(event_date) AS first_login_date`**: For each `player_id`, find the earliest `event_date`, which represents the player's first login date.
- **`FROM Activity`**: The data is sourced from the `Activity` table.
- **`GROUP BY player_id`**: This ensures that the query returns one row per player, with their first login date.

### 2. `ConsecutiveLogin` CTE

**Purpose**: Determine which players logged in on the day following their first login.

```sql
ConsecutiveLogin AS (
    SELECT DISTINCT a.player_id
    FROM Activity a
    JOIN FirstLogin f
    ON a.player_id = f.player_id
    WHERE a.event_date = DATE_ADD(f.first_login_date, INTERVAL 1 DAY)
)
```

- **`SELECT DISTINCT a.player_id`**: Select unique player IDs who meet the criteria.
- **`FROM Activity a`**: Data is taken from the `Activity` table.
- **`JOIN FirstLogin f ON a.player_id = f.player_id`**: Join the `Activity` table with the `FirstLogin` CTE to compare each player’s login dates.
- **`WHERE a.event_date = DATE_ADD(f.first_login_date, INTERVAL 1 DAY)`**: Filter to find players who logged in on the day after their first login date.

### 3. Final Calculation

**Purpose**: Calculate the fraction of players who logged in on the day after their first login.

```sql
SELECT 
    ROUND(COUNT(DISTINCT c.player_id) / COUNT(DISTINCT f.player_id), 2) AS fraction
FROM 
    FirstLogin f
LEFT JOIN 
    ConsecutiveLogin c
ON f.player_id = c.player_id;
```

- **`COUNT(DISTINCT c.player_id)`**: Counts the number of players who logged in on the day after their first login.
- **`COUNT(DISTINCT f.player_id)`**: Counts the total number of unique players.
- **`ROUND(..., 2)`**: Rounds the resulting fraction to 2 decimal places.
- **`LEFT JOIN ConsecutiveLogin c ON f.player_id = c.player_id`**: Perform a left join to include all players from `FirstLogin` and match them with those in `ConsecutiveLogin`. Players who didn't log in on the consecutive day will have `NULL` values for `c.player_id`.
