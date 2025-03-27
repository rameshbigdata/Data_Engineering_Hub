```sql
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    COUNT(CASE WHEN state = 'approved' THEN 1 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM
    Transactions
GROUP BY
    month, country;
```

### Explanation:

1. **`DATE_FORMAT(trans_date, '%Y-%m') AS month`**:
   - **Purpose**: Extracts and formats the year and month from the `trans_date` column.
   - **Function**: `DATE_FORMAT` is used to convert the date into a string formatted as "YYYY-MM". This allows grouping of transactions by month and year.

2. **`country`**:
   - **Purpose**: Includes the country for which the transaction data is being aggregated.
   - **Function**: This ensures that the results are grouped not only by month but also by country.

3. **`COUNT(*) AS trans_count`**:
   - **Purpose**: Counts the total number of transactions for each group (each month and country combination).
   - **Function**: `COUNT(*)` counts all rows within each group.

4. **`COUNT(CASE WHEN state = 'approved' THEN 1 END) AS approved_count`**:
   - **Purpose**: Counts the number of approved transactions.
   - **Function**: `COUNT(CASE WHEN state = 'approved' THEN 1 END)` counts only those transactions where the `state` is 'approved'. If the condition is true, it adds 1 to the count.

5. **`SUM(amount) AS trans_total_amount`**:
   - **Purpose**: Calculates the total amount of all transactions.
   - **Function**: `SUM(amount)` adds up the `amount` column for all transactions within each group.

6. **`SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount`**:
   - **Purpose**: Calculates the total amount of approved transactions.
   - **Function**: `SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)` sums the `amount` for transactions where `state` is 'approved'. For transactions not approved, it adds 0, ensuring only approved amounts are summed.

7. **`FROM Transactions`**:
   - **Purpose**: Specifies the source table from which to retrieve the data.
   - **Function**: This tells the SQL engine to perform the operations on the `Transactions` table.

8. **`GROUP BY month, country`**:
   - **Purpose**: Groups the results by month and country.
   - **Function**: This ensures that the calculations (counting and summing) are done separately for each combination of month and country. Each group will have its own counts and totals.

By running this query, you get a summary for each month and country, including the total number of transactions, the count and total amount of approved transactions, and the total amount of all transactions.