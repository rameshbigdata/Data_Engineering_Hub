To find the IDs of dates where the temperature was higher compared to the previous day, you need to compare each day's temperature with the temperature from the day before. This involves joining the `Weather` table with itself to match each record with the previous day's record.

### SQL Query Explanation

Here is the SQL query that achieves this:

```sql
SELECT w1.id
FROM Weather w1
JOIN Weather w2
ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature;
```

#### Components of the Query

1. **SELECT Clause:**
   - `w1.id`: This selects the `id` from the first instance of the `Weather` table (aliased as `w1`), which corresponds to the current day's record.

2. **FROM Clause:**
   - `Weather w1`: This specifies the main table, aliased as `w1`, representing the current day's record.

3. **JOIN Clause:**
   - `JOIN Weather w2 ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)`: This joins the `Weather` table with itself. `w2` represents the previous day's record.
     - **DATE_ADD(w2.recordDate, INTERVAL 1 DAY)**: This function is used to get the date that is one day before the current record date.
     - The join condition matches the current day's `recordDate` (`w1.recordDate`) with the date that is one day after the previous day's `recordDate` (`w2.recordDate`).

4. **WHERE Clause:**
   - `WHERE w1.temperature > w2.temperature`: This filters the results to include only those rows where the temperature of the current day (`w1.temperature`) is greater than the temperature of the previous day (`w2.temperature`).

### How It Works

- **Self-Join:**
  - The `JOIN` operation connects each record in the `Weather` table (`w1`) with the record from the previous day (`w2`).
  - `DATE_ADD(w2.recordDate, INTERVAL 1 DAY)` computes the date that follows the previous day’s `recordDate`.

- **Filtering:**
  - The `WHERE` clause ensures that only records where the current day’s temperature is higher than the previous day’s temperature are selected.

### Example

Given the input table:

**Weather Table:**

```
| id | recordDate | temperature |
|----|------------|-------------|
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
```

- For `id = 2` (2015-01-02), the temperature (25) is higher than the temperature on 2015-01-01 (10).
- For `id = 4` (2015-01-04), the temperature (30) is higher than the temperature on 2015-01-03 (20).

The output will be:

```
| id |
|----|
| 2  |
| 4  |
```

This query correctly identifies the dates where the temperature was higher than the previous day’s temperature, based on the requirements.