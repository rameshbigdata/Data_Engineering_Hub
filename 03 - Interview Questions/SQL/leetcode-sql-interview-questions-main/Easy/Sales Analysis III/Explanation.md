To solve this problem, we need to find the products that were **only** sold in the first quarter of 2019 (i.e., between 2019-01-01 and 2019-03-31) and not at any other time in the year.

We can approach the solution in the following steps:

1. **Filter Sales in the First Quarter**:
   We first identify sales that occurred between 2019-01-01 and 2019-03-31.

2. **Check for Products Sold Exclusively in the First Quarter**:
   We ensure that the product was **only sold** during this period and not at any other time. This can be done by:
   - Finding the product IDs of sales in the first quarter.
   - Checking if the same product appears in sales outside this period.

3. **Join with Product Table**:
   Once we have the product IDs that meet the criteria, we join this information with the `Product` table to retrieve the `product_name` along with the `product_id`.

### SQL Query:

```sql
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
```

### Explanation:

1. **first_quarter_sales**: This CTE (`Common Table Expression`) retrieves distinct `product_id`s from the `Sales` table where the `sale_date` falls between `2019-01-01` and `2019-03-31`.

2. **other_sales**: This CTE retrieves distinct `product_id`s from the `Sales` table where the `sale_date` is **outside** the first quarter (i.e., before `2019-01-01` or after `2019-03-31`).

3. **Main Query**:
   - We join the `Product` table with the `first_quarter_sales` CTE to get the products that were sold in the first quarter.
   - We then use a `LEFT JOIN` with `other_sales` to find products that were **not** sold outside the first quarter. The `WHERE os.product_id IS NULL` condition ensures that we only select products that do not appear in `other_sales` (i.e., products that were sold exclusively in the first quarter).

### Output:
This query will return the products that were only sold in the first quarter of 2019, including both the `product_id` and `product_name`. 

For the given example, the output would be:

```
+-------------+--------------+
| product_id  | product_name |
+-------------+--------------+
| 1           | S8           |
+-------------+--------------+
```