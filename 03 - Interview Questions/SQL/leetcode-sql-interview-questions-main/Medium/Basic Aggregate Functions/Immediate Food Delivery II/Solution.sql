WITH FirstOrders AS (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
),
CustomerFirstOrders AS (
    SELECT d.delivery_id, d.customer_id, d.order_date, d.customer_pref_delivery_date
    FROM Delivery d
    JOIN FirstOrders fo
    ON d.customer_id = fo.customer_id AND d.order_date = fo.first_order_date
)
SELECT ROUND(100.0 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) 
             / COUNT(*), 2) AS immediate_percentage
FROM CustomerFirstOrders;