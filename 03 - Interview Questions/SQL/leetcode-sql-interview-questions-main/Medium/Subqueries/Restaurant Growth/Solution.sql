WITH DailyAmounts AS (
    SELECT 
        visited_on,
        SUM(amount) AS day_sum
    FROM Customer
    GROUP BY visited_on
),
MovingWindow AS (
    SELECT
        t1.visited_on,
        SUM(t2.day_sum) AS total_amount
    FROM DailyAmounts t1
    JOIN DailyAmounts t2
    ON t2.visited_on BETWEEN DATE_SUB(t1.visited_on, INTERVAL 6 DAY) AND t1.visited_on
    GROUP BY t1.visited_on
    HAVING COUNT(DISTINCT t2.visited_on) = 7
)
SELECT 
    visited_on,
    total_amount AS amount,
    ROUND(total_amount / 7, 2) AS average_amount
FROM MovingWindow
ORDER BY visited_on;
