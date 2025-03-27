WITH CTE AS (
    SELECT 
        stock_name,
        operation,
        operation_day,
        price,
        ROW_NUMBER() OVER (PARTITION BY stock_name, operation ORDER BY operation_day) AS rn
    FROM 
        Stocks
)
SELECT 
    b.stock_name,
    SUM(s.price - b.price) AS capital_gain_loss
FROM 
    CTE b
JOIN 
    CTE s ON b.stock_name = s.stock_name AND b.rn = s.rn
WHERE 
    b.operation = 'Buy' AND s.operation = 'Sell'
GROUP BY 
    b.stock_name;
