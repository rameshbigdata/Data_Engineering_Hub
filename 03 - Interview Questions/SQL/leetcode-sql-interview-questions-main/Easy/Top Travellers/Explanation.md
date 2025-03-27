To report the total distance traveled by each user from the `Users` and `Rides` tables, we can follow these steps:

### Steps:

1. **Join the `Users` and `Rides` tables**: We will use a `LEFT JOIN` to ensure that all users are included in the result, even those who haven't taken any rides. If a user has no rides, their total traveled distance will be `NULL`, which we will treat as `0`.
  
2. **Sum the total distance for each user**: We will aggregate the rides for each user and calculate the total distance traveled.

3. **Order the result**: The result should be ordered by:
   - `travelled_distance` in descending order.
   - If two users have traveled the same distance, order them by `name` in ascending order.

### SQL Query:

```sql
SELECT 
    u.name,
    IFNULL(SUM(r.distance), 0) AS travelled_distance
FROM 
    Users u
LEFT JOIN 
    Rides r
ON 
    u.id = r.user_id
GROUP BY 
    u.id, u.name
ORDER BY 
    travelled_distance DESC,
    u.name ASC;
```

### Explanation:

- **`LEFT JOIN`**: This ensures that every user from the `Users` table is included, even those who have no corresponding rides in the `Rides` table.
- **`IFNULL(SUM(r.distance), 0)`**: This handles cases where a user has no rides (i.e., the `SUM` would return `NULL`), converting it to `0`.
- **`GROUP BY u.id, u.name`**: We group by `id` and `name` to ensure each user appears only once in the result, with their total distance summed up.
- **`ORDER BY travelled_distance DESC, u.name ASC`**: The results are first ordered by the total distance in descending order. If two users have the same traveled distance, they are ordered alphabetically by their name.

### Output Example:

For the given input:

```
Users:
+------+-----------+
| id   | name      |
+------+-----------+
| 1    | Alice     |
| 2    | Bob       |
| 3    | Alex      |
| 4    | Donald    |
| 7    | Lee       |
| 13   | Jonathan  |
| 19   | Elvis     |
+------+-----------+

Rides:
+------+----------+----------+
| id   | user_id  | distance |
+------+----------+----------+
| 1    | 1        | 120      |
| 2    | 2        | 317      |
| 3    | 3        | 222      |
| 4    | 7        | 100      |
| 5    | 13       | 312      |
| 6    | 19       | 50       |
| 7    | 7        | 120      |
| 8    | 19       | 400      |
| 9    | 7        | 230      |
+------+----------+----------+
```

The output will be:

```
+----------+--------------------+
| name     | travelled_distance |
+----------+--------------------+
| Elvis    | 450                |
| Lee      | 450                |
| Bob      | 317                |
| Jonathan | 312                |
| Alex     | 222                |
| Alice    | 120                |
| Donald   | 0                  |
+----------+--------------------+
```

This query ensures we get the correct total distance for each user, with proper handling for users who haven't taken any rides, and the correct ordering by traveled distance and name.