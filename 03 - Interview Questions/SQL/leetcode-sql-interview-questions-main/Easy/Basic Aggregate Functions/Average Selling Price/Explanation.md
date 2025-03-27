# Explanation:

1. **Step 1: Revenue Calculation**
   We use a Common Table Expression (CTE) named `Revenue` to calculate the total revenue and total units sold for each product.

   ```sql
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
   )
   ```

   - **`LEFT JOIN`**: This joins the `Prices` table (`p`) with the `UnitsSold` table (`u`) on the `product_id` column. We use a `LEFT JOIN` because we want to keep all the records from `Prices` even if there are no matching sales in `UnitsSold`.
   
   - **`u.purchase_date BETWEEN p.start_date AND p.end_date`**: This condition ensures that we only join rows where the `purchase_date` falls within the pricing period (`start_date` to `end_date`).

   - **`SUM(u.units * p.price)`**: This calculates the total revenue for each product by multiplying the number of units sold by the price during the valid date range.

   - **`COALESCE(..., 0)`**: This function is used to handle cases where there are no sales for a product. If no matching sales data is found, `SUM()` would return `NULL`, so `COALESCE` replaces `NULL` with `0`.

   - **`GROUP BY p.product_id`**: This groups the results by `product_id`, so we can calculate total revenue and total units sold for each product.

2. **Step 2: Average Price Calculation**
   We then calculate the average selling price for each product in another CTE called `AveragePrice`.

   ```sql
   AveragePrice AS (
       SELECT
           product_id,
           ROUND(CASE WHEN total_units = 0 THEN 0 ELSE total_revenue / total_units END, 2) AS average_price
       FROM Revenue
   )
   ```

   - **`CASE WHEN total_units = 0 THEN 0 ELSE total_revenue / total_units END`**: This `CASE` statement ensures that if no units were sold (i.e., `total_units = 0`), the average price will be `0`. Otherwise, it calculates the average price as `total_revenue / total_units`.
   
   - **`ROUND(..., 2)`**: The result is rounded to two decimal places, as specified in the problem.

3. **Step 3: Final Selection**
   Finally, we return the product IDs and their corresponding average prices.

   ```sql
   SELECT
       p.product_id,
       COALESCE(a.average_price, 0) AS average_price
   FROM Prices p
   LEFT JOIN AveragePrice a
       ON p.product_id = a.product_id
   GROUP BY p.product_id, a.average_price;
   ```

   - **`LEFT JOIN AveragePrice a ON p.product_id = a.product_id`**: This joins the `Prices` table with the `AveragePrice` CTE to retrieve the calculated average price for each product.

   - **`COALESCE(a.average_price, 0)`**: If no average price is found (i.e., the product had no sales), the `COALESCE` function ensures that the result will show `0` as the average price.

   - **`GROUP BY p.product_id, a.average_price`**: This ensures that we group the results by product ID and the calculated average price, even if the product was never sold.

### Example Walkthrough:

Given the input tables:

**Prices Table:**

```
| product_id | start_date | end_date   | price |
|------------|------------|------------|-------|
| 1          | 2019-02-17 | 2019-02-28 | 5     |
| 1          | 2019-03-01 | 2019-03-22 | 20    |
| 2          | 2019-02-01 | 2019-02-20 | 15    |
| 2          | 2019-02-21 | 2019-03-31 | 30    |
```

**UnitsSold Table:**

```
| product_id | purchase_date | units |
|------------|---------------|-------|
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
```

The steps for calculating the average price are as follows:

- **For product 1**:
  - On `2019-02-25`, 100 units were sold at a price of 5.
  - On `2019-03-01`, 15 units were sold at a price of 20.
  - Total revenue = `(100 * 5) + (15 * 20) = 500 + 300 = 800`.
  - Total units sold = `100 + 15 = 115`.
  - Average price = `800 / 115 = 6.96`.

- **For product 2**:
  - On `2019-02-10`, 200 units were sold at a price of 15.
  - On `2019-03-22`, 30 units were sold at a price of 30.
  - Total revenue = `(200 * 15) + (30 * 30) = 3000 + 900 = 3900`.
  - Total units sold = `200 + 30 = 230`.
  - Average price = `3900 / 230 = 16.96`.

### Final Output:

```
| product_id | average_price |
|------------|---------------|
| 1          | 6.96          |
| 2          | 16.96         |
```