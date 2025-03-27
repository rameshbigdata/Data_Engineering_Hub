### Problem Statement:

We are given two tables, **Customer** and **Product**.

- **Customer** table contains information about customer purchases, including `customer_id` and `product_key`. It may contain duplicate rows.
- **Product** table contains a list of all unique products, identified by `product_key`.

The task is to identify and report all the customers who have purchased **every product** listed in the Product table.

### Example:

Input:
- **Customer Table**:
    ```
    +-------------+-------------+
    | customer_id | product_key |
    +-------------+-------------+
    | 1           | 5           |
    | 2           | 6           |
    | 3           | 5           |
    | 3           | 6           |
    | 1           | 6           |
    +-------------+-------------+
    ```
- **Product Table**:
    ```
    +-------------+
    | product_key |
    +-------------+
    | 5           |
    | 6           |
    +-------------+
    ```

Output:
```
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
```

### Explanation:

The Product table lists two products (5 and 6). Customers 1 and 3 have both purchased these two products, while customer 2 has only purchased product 6, and is thus excluded from the result.

### Approach:

1. **Count Total Distinct Products**:
   We first need to find out how many distinct products are listed in the Product table. This will help us understand how many products each customer needs to have purchased to qualify.

2. **Count the Number of Distinct Products Each Customer Purchased**:
   We then need to count how many distinct products each customer has purchased. This is done by grouping the purchases by customer.

3. **Filter Customers**:
   Finally, we filter out the customers whose count of distinct products matches the total number of products in the Product table. These are the customers who have purchased all the available products.

### Solution (Step-by-Step SQL Query):

```sql
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
```

### Explanation of the Solution:

- **Step 1**: We create a common table expression (CTE) named `TotalProducts`, which calculates the total number of distinct products available in the Product table using the `COUNT(DISTINCT product_key)` function.

- **Step 2**: Another CTE, `CustomerProductCount`, counts how many distinct products each customer has purchased by grouping the rows in the Customer table by `customer_id` and using the `COUNT(DISTINCT product_key)` function.

- **Step 3**: We join the results from the two CTEs (`CustomerProductCount` and `TotalProducts`) on the condition that the number of distinct products a customer has purchased (`purchased_product_count`) matches the total number of distinct products (`total_product_count`). This will give us the customers who have purchased all the products.

By following this logic, we can successfully identify and report the customers who have purchased every product listed in the Product table.