To solve the problem of finding all actor-director pairs that have collaborated at least three times, you can use the following SQL query:

```sql
SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;
```

### Explanation:
1. **SELECT**: This part specifies the columns we want to retrieve, which are `actor_id` and `director_id`.

2. **FROM**: We specify the table we are querying from, which is `ActorDirector`.

3. **GROUP BY**: We group the results by `actor_id` and `director_id` so that we can count the number of collaborations for each unique pair.

4. **HAVING**: This clause filters the grouped results to include only those pairs where the count of collaborations (rows) is 3 or more.

### Result:
This query will return all pairs of `actor_id` and `director_id` that meet the criteria, in any order.