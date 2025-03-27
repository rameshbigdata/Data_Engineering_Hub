To solve the problem of reporting the latest login for all users in the year 2020 from the Logins table, you can use the following SQL query:

```sql
SELECT user_id, MAX(time_stamp) AS last_stamp
FROM Logins
WHERE time_stamp >= '2020-01-01' AND time_stamp < '2021-01-01'
GROUP BY user_id;
```

### Explanation:

1. **WHERE Clause**: 
   - We filter the records to include only those logins that occurred in the year 2020 by specifying the timestamp range from January 1, 2020, to just before January 1, 2021.

2. **MAX Function**: 
   - We use `MAX(time_stamp)` to find the latest login time for each user.

3. **GROUP BY Clause**: 
   - We group the results by `user_id` to ensure that we get one row per user with their latest login time.

This query will return the desired result table with the latest login time for each user who logged in during 2020.