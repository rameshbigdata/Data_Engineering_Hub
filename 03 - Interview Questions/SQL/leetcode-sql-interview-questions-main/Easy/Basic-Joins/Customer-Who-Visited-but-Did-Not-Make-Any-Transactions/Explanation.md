To find the customers who visited the mall but did not make any transactions, and to count the number of such visits, you can use a SQL query that combines data from the `Visits` and `Transactions` tables. Here’s a step-by-step explanation of the solution:

### Problem Breakdown

1. **Tables Involved:**
   - **Visits:** Contains records of customer visits. Each row includes `visit_id` and `customer_id`.
   - **Transactions:** Contains records of transactions made during a visit. Each row includes `transaction_id`, `visit_id`, and `amount`.

2. **Objective:**
   - Identify customers who visited the mall but did not make any transactions.
   - Count how many times these customers visited without making a transaction.

### SQL Query Explanation

```sql
SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t ON v.visit_id = t.visit_id
WHERE t.visit_id IS NULL
GROUP BY v.customer_id;
```

#### Components of the Query

1. **SELECT Clause:**
   - `v.customer_id`: This selects the `customer_id` from the `Visits` table.
   - `COUNT(v.visit_id) AS count_no_trans`: This counts the number of visits where no transaction was made and aliases it as `count_no_trans`.

2. **FROM Clause:**
   - `Visits v`: Specifies that the query starts with the `Visits` table, aliased as `v`.

3. **LEFT JOIN Clause:**
   - `LEFT JOIN Transactions t ON v.visit_id = t.visit_id`: This performs a left join between the `Visits` table and the `Transactions` table.
     - **Left Join:** Ensures all rows from the `Visits` table are included in the result, even if there is no corresponding row in the `Transactions` table.
     - `v.visit_id = t.visit_id`: This specifies the condition for the join, linking visits to transactions.

4. **WHERE Clause:**
   - `WHERE t.visit_id IS NULL`: Filters the results to include only those visits that do not have any corresponding transactions. If `t.visit_id` is `NULL`, it means that visit did not have any transaction.

5. **GROUP BY Clause:**
   - `GROUP BY v.customer_id`: Groups the results by `customer_id` so that the count of visits without transactions can be aggregated for each customer.

#### How It Works

- **Joining Tables:**
  - The `LEFT JOIN` ensures that every visit is included in the result, whether or not it has a matching transaction record.
  
- **Filtering Non-Transactions:**
  - The `WHERE t.visit_id IS NULL` condition filters out visits that have corresponding transaction records, leaving only those visits without transactions.

- **Counting Visits:**
  - `COUNT(v.visit_id)` counts the number of visits without transactions for each customer.

- **Grouping Results:**
  - `GROUP BY v.customer_id` ensures that the count of non-transaction visits is aggregated for each customer.

### Example

Given the input tables:

**Visits Table:**

```
| visit_id | customer_id |
|----------|-------------|
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |
```

**Transactions Table:**

```
| transaction_id | visit_id | amount |
|----------------|----------|--------|
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |
```

The query results will be:

```
| customer_id | count_no_trans |
|-------------|----------------|
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |
```

Here:
- Customer 54 visited the mall 3 times. Out of these, 2 visits had no transactions.
- Customer 30 visited the mall once and had no transactions.
- Customer 96 visited the mall once and had no transactions.
