To calculate the cancellation rate of requests made by unbanned users for the specified days, you can use a SQL query that joins the `Trips` and `Users` tables. This will allow you to filter out the banned clients and drivers and then compute the cancellation rate for each day. Here’s how you can do it:

```sql
SELECT 
    request_at AS Day,
    ROUND(
        SUM(CASE WHEN t.status IN ('cancelled_by_driver', 'cancelled_by_client') THEN 1 ELSE 0 END) 
        / NULLIF(COUNT(*), 0), 2) AS `Cancellation Rate`
FROM 
    Trips t
JOIN 
    Users c ON t.client_id = c.users_id AND c.banned = 'No'
JOIN 
    Users d ON t.driver_id = d.users_id AND d.banned = 'No'
WHERE 
    t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY 
    request_at
ORDER BY 
    request_at;
```

### Explanation of the Query:
1. **SELECT Clause**: 
   - We select the `request_at` date and alias it as `Day`.
   - We calculate the cancellation rate by counting the number of canceled requests (either by the client or the driver) and dividing it by the total count of requests.

2. **SUM with CASE**:
   - `SUM(CASE WHEN t.status IN ('cancelled_by_driver', 'cancelled_by_client') THEN 1 ELSE 0 END)` counts the canceled requests.

3. **NULLIF**:
   - `NULLIF(COUNT(*), 0)` is used to avoid division by zero. If there are no requests, it returns NULL instead of zero.

4. **JOIN**:
   - The `Trips` table is joined with the `Users` table twice, once for clients and once for drivers, filtering out those who are banned.

5. **WHERE Clause**:
   - This filters the trips to only include those between '2013-10-01' and '2013-10-03'.

6. **GROUP BY**: 
   - This groups the results by each day.

7. **ORDER BY**: 
   - Finally, the results are ordered by the date.

### Output:
This will return the cancellation rates for each day within the specified date range, rounded to two decimal points as required.