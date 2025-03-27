### Problem Statement

You have a table named `Customer` that contains information about customer transactions at a restaurant:

- **`customer_id`**: Unique ID for each customer.
- **`name`**: Name of the customer.
- **`visited_on`**: Date on which the customer visited the restaurant.
- **`amount`**: Total amount paid by the customer on that day.

You need to compute the moving average of the total amount paid over a 7-day window for each day in the data. This means for each day, you should calculate the average of the total amounts paid over that day and the six preceding days. The result should be rounded to two decimal places and ordered by `visited_on` in ascending order.

### Solution Explanation

The solution involves the following steps:

1. **Aggregate Daily Amounts**:
   - First, calculate the total amount paid on each `visited_on` date by grouping the data by `visited_on`.

2. **Calculate Moving Sums**:
   - For each day, compute the sum of amounts for a 7-day window that ends on that day. This involves summing up the daily amounts for the current day and the six preceding days.

3. **Filter and Compute Moving Average**:
   - Ensure that there are exactly 7 days in the window (this can be done by checking if there are 7 distinct days in the window).
   - Compute the average amount from the total amount for the 7-day window and round it to two decimal places.

### Detailed SQL Query

```sql
WITH DailyAmounts AS (
    -- Aggregate the total amount paid on each day
    SELECT 
        visited_on,
        SUM(amount) AS day_sum
    FROM Customer
    GROUP BY visited_on
),
MovingWindow AS (
    -- Calculate the total amount for a 7-day window ending on each day
    SELECT
        t1.visited_on,
        SUM(t2.day_sum) AS total_amount
    FROM DailyAmounts t1
    JOIN DailyAmounts t2
    ON t2.visited_on BETWEEN DATE_SUB(t1.visited_on, INTERVAL 6 DAY) AND t1.visited_on
    GROUP BY t1.visited_on
    HAVING COUNT(DISTINCT t2.visited_on) = 7
)
-- Select the final results with rounded average amount
SELECT 
    visited_on,
    total_amount AS amount,
    ROUND(total_amount / 7, 2) AS average_amount
FROM MovingWindow
ORDER BY visited_on;
```

### Explanation of the Query

1. **`DailyAmounts` CTE**:
   - Aggregates the total amount paid per day. This results in a table where each row represents a day and the total amount paid on that day.

2. **`MovingWindow` CTE**:
   - Joins the `DailyAmounts` table with itself to compute the sum of daily amounts over a 7-day window ending on each date. The `BETWEEN DATE_SUB(t1.visited_on, INTERVAL 6 DAY) AND t1.visited_on` condition ensures that we include the current day and the previous six days.
   - **`HAVING COUNT(DISTINCT t2.visited_on) = 7`** ensures that exactly 7 distinct days are included in the window. This avoids issues where the window might have fewer than 7 days (e.g., at the start of the dataset).

3. **Final SELECT**:
   - Computes the average amount for each 7-day window by dividing `total_amount` by 7 and rounding to two decimal places.
   - Orders the result by `visited_on` to match the required output format.

### Example Output

Given the example data:

```sql
+--------------+--------------+----------------+
| visited_on   | amount       | average_amount |
+--------------+--------------+----------------+
| 2019-01-07   | 860          | 122.86         |
| 2019-01-08   | 840          | 120            |
| 2019-01-09   | 840          | 120            |
| 2019-01-10   | 1000         | 142.86         |
+--------------+--------------+----------------+
```

- **2019-01-07**: Moving average from 2019-01-01 to 2019-01-07 is 122.86.
- **2019-01-08**: Moving average from 2019-01-02 to 2019-01-08 is 120.
- **2019-01-09**: Moving average from 2019-01-03 to 2019-01-09 is 120.
- **2019-01-10**: Moving average from 2019-01-04 to 2019-01-10 is 142.86.

This solution efficiently computes the required moving average and handles the ordering and rounding of results.