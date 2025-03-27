To determine the last person that can board a bus without exceeding the weight limit, we need to process the queue in the order defined by the `turn` column, calculate the cumulative weight of the people boarding the bus, and find out who is the last person to board without the total weight exceeding 1000 kilograms.

### SQL Solution Breakdown

1. **Order the Queue**:
   - Sort people based on their `turn` column to ensure we are processing the queue in the correct order.

2. **Calculate Cumulative Weight**:
   - Compute the running total of weights to keep track of the cumulative weight of people boarding the bus.

3. **Find the Last Person Who Can Board**:
   - Select the last person whose cumulative weight is less than or equal to 1000 kilograms.

### Solution

Here’s how you can write the SQL query to achieve this:

```sql
WITH OrderedQueue AS (
    SELECT person_name, weight, turn
    FROM Queue
    ORDER BY turn
),
RunningTotal AS (
    SELECT 
        person_name,
        weight,
        turn,
        SUM(weight) OVER (ORDER BY turn) AS total_weight
    FROM OrderedQueue
)
SELECT person_name
FROM RunningTotal
WHERE total_weight <= 1000
ORDER BY turn DESC
LIMIT 1;
```

### Explanation

1. **OrderedQueue CTE**:
   - **Purpose**: Orders the queue based on the `turn` column so that we process people in the correct boarding order.
   - **Query**:
     ```sql
     WITH OrderedQueue AS (
         SELECT person_name, weight, turn
         FROM Queue
         ORDER BY turn
     )
     ```

2. **RunningTotal CTE**:
   - **Purpose**: Computes the cumulative weight for each person using the `SUM(weight) OVER (ORDER BY turn)` window function.
   - **Query**:
     ```sql
     RunningTotal AS (
         SELECT 
             person_name,
             weight,
             turn,
             SUM(weight) OVER (ORDER BY turn) AS total_weight
         FROM OrderedQueue
     )
     ```

3. **Final Selection**:
   - **Purpose**: Select the last person whose total weight is within the limit of 1000 kilograms. 
   - **Query**:
     ```sql
     SELECT person_name
     FROM RunningTotal
     WHERE total_weight <= 1000
     ORDER BY turn DESC
     LIMIT 1;
     ```

   - **Explanation**:
     - `WHERE total_weight <= 1000`: Filters out people who exceed the weight limit.
     - `ORDER BY turn DESC`: Orders the results in reverse to get the most recent person who still fits within the weight limit.
     - `LIMIT 1`: Ensures that only the last valid person is selected.

### Example

Given the `Queue` table:

```sql
+-----------+-------------+--------+------+
| person_id | person_name | weight | turn |
+-----------+-------------+--------+------+
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |
+-----------+-------------+--------+------+
```

**Output**:

```sql
+-------------+
| person_name |
+-------------+
| John Cena   |
+-------------+
```

- **Alice**: Cumulative weight 250 (turn 1)
- **Alex**: Cumulative weight 600 (turn 2)
- **John Cena**: Cumulative weight 1000 (turn 3)
- **Marie**: Cumulative weight 1200 (turn 4) — Exceeds limit

John Cena is the last person who can board the bus without exceeding the weight limit of 1000 kilograms.