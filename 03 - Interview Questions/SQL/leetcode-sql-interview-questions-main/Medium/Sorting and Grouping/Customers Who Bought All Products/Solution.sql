-- Step 1: Count the total number of distinct products
WITH TotalProducts AS (
    SELECT COUNT(DISTINCT product_key) AS total_product_count
    FROM Product
),

-- Step 2: Count the number of distinct products each customer has purchased
CustomerProductCount AS (
    SELECT customer_id, COUNT(DISTINCT product_key) AS purchased_product_count
    FROM Customer
    GROUP BY customer_id
)

-- Step 3: Find customers who have purchased all distinct products
SELECT c.customer_id
FROM CustomerProductCount c
JOIN TotalProducts t
ON c.purchased_product_count = t.total_product_count;
