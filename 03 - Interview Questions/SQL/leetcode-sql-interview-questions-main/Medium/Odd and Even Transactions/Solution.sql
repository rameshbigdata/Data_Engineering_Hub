WITH transaction_sums AS (
    SELECT 
        transaction_date,
        amount,
        CASE 
            WHEN amount % 2 = 0 THEN 'even'
            ELSE 'odd'
        END AS type
    FROM 
        transactions
)

SELECT 
    transaction_date,
    SUM(CASE WHEN type = 'odd' THEN amount ELSE 0 END) AS odd_sum,
    SUM(CASE WHEN type = 'even' THEN amount ELSE 0 END) AS even_sum
FROM 
    transaction_sums
GROUP BY 
    transaction_date
ORDER BY 
    transaction_date;
