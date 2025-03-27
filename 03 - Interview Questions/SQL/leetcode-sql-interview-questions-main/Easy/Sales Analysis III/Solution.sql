WITH first_quarter_sales AS (
    SELECT DISTINCT product_id
    FROM Sales
    WHERE sale_date BETWEEN '2019-01-01' AND '2019-03-31'
),
other_sales AS (
    SELECT DISTINCT product_id
    FROM Sales
    WHERE sale_date < '2019-01-01' OR sale_date > '2019-03-31'
)
SELECT p.product_id, p.product_name
FROM Product p
JOIN first_quarter_sales fqs
ON p.product_id = fqs.product_id
LEFT JOIN other_sales os
ON p.product_id = os.product_id
WHERE os.product_id IS NULL;
