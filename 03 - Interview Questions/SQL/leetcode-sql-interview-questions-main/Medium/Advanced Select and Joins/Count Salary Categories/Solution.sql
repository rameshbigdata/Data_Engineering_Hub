WITH CategoryCounts AS (
    SELECT
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            ELSE 'High Salary'
        END AS category
    FROM Accounts
),
CategoryList AS (
    SELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'High Salary'
)
SELECT
    cl.category,
    COALESCE(COUNT(cc.category), 0) AS accounts_count
FROM CategoryList cl
LEFT JOIN CategoryCounts cc
ON cl.category = cc.category
GROUP BY cl.category
ORDER BY cl.category;
