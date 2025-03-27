WITH Revenue AS (
    SELECT
        p.product_id,
        COALESCE(SUM(u.units * p.price), 0) AS total_revenue,
        COALESCE(SUM(u.units), 0) AS total_units
    FROM Prices p
    LEFT JOIN UnitsSold u
        ON p.product_id = u.product_id
        AND u.purchase_date BETWEEN p.start_date AND p.end_date
    GROUP BY p.product_id
),
AveragePrice AS (
    SELECT
        product_id,
        ROUND(CASE WHEN total_units = 0 THEN 0 ELSE total_revenue / total_units END, 2) AS average_price
    FROM Revenue
)
SELECT
    p.product_id,
    COALESCE(a.average_price, 0) AS average_price
FROM Prices p
LEFT JOIN AveragePrice a
    ON p.product_id = a.product_id
GROUP BY p.product_id, a.average_price;
