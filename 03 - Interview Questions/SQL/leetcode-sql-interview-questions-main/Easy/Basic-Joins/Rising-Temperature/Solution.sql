SELECT id
FROM Weather
WHERE temperature > (
    SELECT temperature
    FROM Weather AS previous
    WHERE previous.recordDate = DATE_SUB(Weather.recordDate, INTERVAL 1 DAY)
);
