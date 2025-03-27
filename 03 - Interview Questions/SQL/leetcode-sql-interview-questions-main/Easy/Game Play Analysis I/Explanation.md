It looks like the task is to find **the first login date** (i.e., the earliest `event_date`) for each player, rather than the total number of games played. Here's how you can solve that problem using the `Activity` table.

### Task: 
You need to return the **first login date** for each player (the earliest `event_date` for each `player_id`).

### SQL Query:

```sql
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;
```

### Explanation:

- `MIN(event_date)`: This function returns the earliest (`first`) date for each `player_id`.
- `GROUP BY player_id`: This ensures that we group the results by each player so that we get the earliest login for each player.

### Output:

For the given input:

```
| player_id | device_id | event_date | games_played |
| --------- | --------- | ---------- | ------------ |
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
```

The output of the query will be:

```
| player_id | first_login |
| --------- | ----------- |
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
```

This output matches the expected result.