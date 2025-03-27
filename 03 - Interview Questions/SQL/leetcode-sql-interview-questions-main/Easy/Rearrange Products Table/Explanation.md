To solve this problem, we need to transform the given table structure into another format where each row represents a product's price in a specific store. Specifically, we need to pivot the data such that each combination of `product_id` and `store` is represented by a row, excluding cases where the price is `NULL` (indicating the product is not available in that store).

We can break the problem down as follows:
1. For each row in the `Products` table, we need to extract the non-null prices for `store1`, `store2`, and `store3`.
2. For each non-null price, we create a new row with the corresponding `product_id`, `store`, and `price`.
3. The resulting table will contain three columns: `product_id`, `store`, and `price`.

Here’s how we can write a SQL query to accomplish this:

```sql
SELECT product_id, 'store1' AS store, store1 AS price
FROM Products
WHERE store1 IS NOT NULL

UNION ALL

SELECT product_id, 'store2' AS store, store2 AS price
FROM Products
WHERE store2 IS NOT NULL

UNION ALL

SELECT product_id, 'store3' AS store, store3 AS price
FROM Products
WHERE store3 IS NOT NULL;
```

### Explanation:
- **First SELECT statement**: We select `product_id`, the string `'store1'` as the store name, and the `store1` column as the price. We include a `WHERE` clause to filter out any rows where the `store1` price is `NULL`.
- **Second SELECT statement**: Similar to the first, but for `store2`.
- **Third SELECT statement**: Similarly, for `store3`.
- **UNION ALL**: We use `UNION ALL` to combine the results of the three `SELECT` queries. We use `UNION ALL` instead of `UNION` to avoid eliminating any duplicate rows (though there shouldn't be any in this case).

### Example Walkthrough:
Given the input:

| product_id | store1 | store2 | store3 |
|------------|--------|--------|--------|
| 0          | 95     | 100    | 105    |
| 1          | 70     | NULL   | 80     |

- The first `SELECT` will return:
  ```
  | product_id | store  | price |
  |------------|--------|-------|
  | 0          | store1 | 95    |
  | 1          | store1 | 70    |
  ```

- The second `SELECT` will return:
  ```
  | product_id | store  | price |
  |------------|--------|-------|
  | 0          | store2 | 100   |
  ```

- The third `SELECT` will return:
  ```
  | product_id | store  | price |
  |------------|--------|-------|
  | 0          | store3 | 105   |
  | 1          | store3 | 80    |
  ```

When combined using `UNION ALL`, the result is:
```
| product_id | store  | price |
|------------|--------|-------|
| 0          | store1 | 95    |
| 1          | store1 | 70    |
| 0          | store2 | 100   |
| 0          | store3 | 105   |
| 1          | store3 | 80    |
```
This matches the expected output.