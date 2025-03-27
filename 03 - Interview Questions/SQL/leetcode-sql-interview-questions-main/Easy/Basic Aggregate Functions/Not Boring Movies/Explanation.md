Let's break down the SQL query and explain each part of the solution:

```sql
SELECT id, movie, description, rating
FROM Cinema
WHERE id % 2 = 1
  AND description != 'boring'
ORDER BY rating DESC;
```

### Explanation:

1. **`SELECT id, movie, description, rating`**:  
   This part of the query specifies which columns to retrieve from the `Cinema` table. It selects the `id`, `movie`, `description`, and `rating` columns. These columns will be included in the result set.

2. **`FROM Cinema`**:  
   This tells the query where to get the data from, which is the `Cinema` table in this case.

3. **`WHERE id % 2 = 1`**:  
   This condition filters the rows by checking whether the `id` of the movie is odd. The expression `id % 2 = 1` is a modulus operation that returns the remainder when the `id` is divided by 2. If the remainder is 1, it means the `id` is an odd number, so only those rows will be selected.

4. **`AND description != 'boring'`**:  
   This condition further filters the results to exclude rows where the `description` is equal to `'boring'`. Only movies whose description is not "boring" will be included.

5. **`ORDER BY rating DESC`**:  
   Finally, this clause sorts the resulting rows by the `rating` column in descending order (`DESC`), meaning movies with higher ratings will appear first in the result set.

### Example Walkthrough:

Using the input data from the example:

```
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 1  | War        | great 3D    | 8.9    |
| 2  | Science    | fiction     | 8.5    |
| 3  | irish      | boring      | 6.2    |
| 4  | Ice song   | Fantacy     | 8.6    |
| 5  | House card | Interesting | 9.1    |
+----+------------+-------------+--------+
```

1. **Filter by odd-numbered IDs**:  
   Only rows with `id = 1`, `id = 3`, and `id = 5` will be selected (since these are the odd-numbered IDs).

2. **Filter out "boring" descriptions**:  
   Row with `id = 3` has a "boring" description, so it will be excluded from the result.

3. **Order by rating in descending order**:  
   The remaining rows (with `id = 1` and `id = 5`) will be sorted by their rating, so the final output will be:

```
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 5  | House card | Interesting | 9.1    |
| 1  | War        | great 3D    | 8.9    |
+----+------------+-------------+--------+
```