### Problem Explanation

You have a table called `Stadium` that tracks visits to a stadium, recording the visit date, the number of people attending, and a unique visit ID. The goal is to identify and return records where there are three or more consecutive visits (based on increasing ID) with a number of attendees equal to or exceeding 100. The output should be sorted by the visit date.

### Solution Breakdown

1. **Identify Consecutive Groups**: 
   To find groups of consecutive IDs where the number of attendees is 100 or more, we can use a window function to create a grouping mechanism. The idea is to use two `ROW_NUMBER()` calculations:
   - The first `ROW_NUMBER()` simply numbers the rows by `id`.
   - The second `ROW_NUMBER()` numbers rows while partitioning by a condition: whether the number of attendees is at least 100. The difference between these two numbers will create groups of consecutive IDs with attendees >= 100.

2. **Creating the Grouping**:
   The difference between the two `ROW_NUMBER()` results gives us a way to group rows:
   - If two rows are consecutive and both have attendees >= 100, their group identifier (`grp`) will be the same.
   - If one of them has fewer than 100 attendees, the group identifier changes.

3. **Filter Groups**:
   After identifying the groups, we need to filter them:
   - We only want groups that have three or more members. This is done using a `HAVING` clause on a grouped subquery.

4. **Final Selection**:
   Finally, we select the records from our original dataset that belong to the identified groups of interest and order them by `visit_date`.

### SQL Query

Here’s the SQL query explained:

```sql
WITH ConsecutiveGroups AS (
    SELECT 
        id,
        visit_date,
        people,
        ROW_NUMBER() OVER (ORDER BY id) - 
        ROW_NUMBER() OVER (PARTITION BY (CASE WHEN people >= 100 THEN 1 ELSE 0 END) ORDER BY id) AS grp
    FROM Stadium
)
SELECT 
    id, 
    visit_date, 
    people
FROM 
    ConsecutiveGroups
WHERE 
    people >= 100
    AND grp IN (
        SELECT grp
        FROM ConsecutiveGroups
        WHERE people >= 100
        GROUP BY grp
        HAVING COUNT(*) >= 3
    )
ORDER BY visit_date;
```

### Key Points

- **CTE (Common Table Expression)**: The `WITH ConsecutiveGroups AS (...)` creates a temporary result set used in the main query.
- **ROW_NUMBER()**: Helps to identify the order of the rows while creating a method to group them based on the attendance condition.
- **Filtering Logic**: The `WHERE` clause filters out rows with fewer than 100 attendees and includes only those groups that have at least three records.
- **Sorting**: The final result is ordered by `visit_date` to meet the output requirements.

This approach efficiently identifies the required records while leveraging SQL window functions for clarity and performance.