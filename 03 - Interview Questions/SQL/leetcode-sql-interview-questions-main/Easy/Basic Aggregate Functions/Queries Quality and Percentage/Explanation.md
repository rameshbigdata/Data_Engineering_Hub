To calculate the `quality` and `poor_query_percentage` for each `query_name`, you can use the following SQL query. This query computes the quality as the average of the ratio between `rating` and `position` for each query, and the poor query percentage as the ratio of queries with a rating less than 3 to the total number of queries, expressed as a percentage.

Here's the SQL query to achieve this:

```sql
SELECT
    query_name,
    ROUND(AVG(rating * 1.0 / position), 2) AS quality,
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS poor_query_percentage
FROM
    Queries
GROUP BY
    query_name;
```

### Explanation:

1. **`quality` Calculation**:
   - `AVG(rating * 1.0 / position)`: This calculates the average ratio of `rating` to `position` for each `query_name`. Multiplying `rating` by `1.0` ensures that division is done in floating-point arithmetic.
   - `ROUND(..., 2)`: Rounds the result to two decimal places.

2. **`poor_query_percentage` Calculation**:
   - `SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)`: Counts the number of queries with a rating less than 3.
   - `* 100.0 / COUNT(*)`: Calculates the percentage of poor queries relative to the total number of queries.
   - `ROUND(..., 2)`: Rounds the percentage to two decimal places.

3. **`GROUP BY query_name`**:
   - Groups the results by `query_name` to calculate the `quality` and `poor_query_percentage` for each distinct query name.

This query provides the required metrics for each query name, rounding them to two decimal places as specified.