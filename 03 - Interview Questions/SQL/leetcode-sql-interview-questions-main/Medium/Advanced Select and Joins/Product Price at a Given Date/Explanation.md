To determine the prices of all products on a specific date, such as 2019-08-16, given that any product not explicitly updated before or on this date should be assumed to have a default price of 10, you can follow these steps:

### Problem Breakdown

1. **Determine the Latest Price Before or On the Given Date**:
   - For each product, find the most recent price change date that is on or before 2019-08-16.

2. **Handle Products Without Any Price Change Before the Given Date**:
   - If a product does not have any price changes before or on the given date, its price should be the default value of 10.

### Solution Explanation

Here’s a SQL query that accomplishes this:

```sql
WITH LatestChange AS (
    SELECT
        product_id,
        new_price,
        change_date
    FROM
        Products
    WHERE
        change_date <= '2019-08-16'
    AND
        (product_id, change_date) IN (
            SELECT
                product_id,
                MAX(change_date)
            FROM
                Products
            WHERE
                change_date <= '2019-08-16'
            GROUP BY
                product_id
        )
)
SELECT
    p.product_id,
    COALESCE(lc.new_price, 10) AS price
FROM
    (SELECT DISTINCT product_id FROM Products) p
LEFT JOIN
    LatestChange lc
ON
    p.product_id = lc.product_id;
```

### Detailed Breakdown

1. **Common Table Expression (CTE) - LatestChange**:
   - **Purpose**: This CTE finds the latest price change for each product up to and including the specified date (2019-08-16).
   - **Query**:
     ```sql
     WITH LatestChange AS (
         SELECT
             product_id,
             new_price,
             change_date
         FROM
             Products
         WHERE
             change_date <= '2019-08-16'
         AND
             (product_id, change_date) IN (
                 SELECT
                     product_id,
                     MAX(change_date)
                 FROM
                     Products
                 WHERE
                     change_date <= '2019-08-16'
                 GROUP BY
                     product_id
             )
     )
     ```
   - **Explanation**:
     - Filters the products to those with change dates on or before 2019-08-16.
     - The subquery within the `IN` clause finds the maximum change date for each product up to 2019-08-16, ensuring we get the latest price before or on the given date.

2. **Final Query**:
   - **Purpose**: Joins the products with the latest price changes found in the CTE and assigns a default price of 10 if there is no change recorded for a product by the specified date.
   - **Query**:
     ```sql
     SELECT
         p.product_id,
         COALESCE(lc.new_price, 10) AS price
     FROM
         (SELECT DISTINCT product_id FROM Products) p
     LEFT JOIN
         LatestChange lc
     ON
         p.product_id = lc.product_id;
     ```
   - **Explanation**:
     - `SELECT DISTINCT product_id FROM Products`: Ensures that we consider every product.
     - `LEFT JOIN LatestChange lc ON p.product_id = lc.product_id`: Joins the products with their latest price.
     - `COALESCE(lc.new_price, 10)`: Uses the `COALESCE` function to assign a default price of 10 if no price is found for the product in the `LatestChange` CTE.

### Example

For the provided `Products` table:

```sql
+----+-----------+-------------+
| id | new_price | change_date |
+----+-----------+-------------+
| 1  | 20        | 2019-08-14  |
| 2  | 50        | 2019-08-14  |
| 1  | 30        | 2019-08-15  |
| 1  | 35        | 2019-08-16  |
| 2  | 65        | 2019-08-17  |
| 3  | 20        | 2019-08-18  |
+----+-----------+-------------+
```

**Output**:
```sql
+------------+-------+
| product_id | price |
+------------+-------+
| 1          | 35    |
| 2          | 50    |
| 3          | 10    |
+------------+-------+
```

- Product 1 has a price of 35 on 2019-08-16.
- Product 2 has a price of 50 on 2019-08-16.
- Product 3 has no price changes before 2019-08-16, so it defaults to 10.

This approach ensures that all products are accounted for with their prices correctly determined based on the given criteria.