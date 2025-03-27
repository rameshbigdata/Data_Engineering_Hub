WITH ConsecutiveGroups AS (
    SELECT 
        id,
        visit_date,
        people,
        ROW_NUMBER() OVER (ORDER BY id) - 
        ROW_NUMBER() OVER (PARTITION BY (CASE WHEN people >= 100 THEN 1 ELSE 0 END) ORDER BY id) AS grp
    FROM Stadium
)
SELECT 
    id, 
    visit_date, 
    people
FROM 
    ConsecutiveGroups
WHERE 
    people >= 100
    AND grp IN (
        SELECT grp
        FROM ConsecutiveGroups
        WHERE people >= 100
        GROUP BY grp
        HAVING COUNT(*) >= 3
    )
ORDER BY visit_date;
