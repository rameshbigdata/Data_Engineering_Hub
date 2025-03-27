To solve the problem of finding each user's join date and the number of orders they made as a buyer in 2019, you can use the following SQL query. This query utilizes a LEFT JOIN to connect the `Users` table with the `Orders` table, filters the orders based on the year, and groups the results to count the orders for each user.

Here's the SQL code:

```sql
SELECT 
    u.user_id AS buyer_id,
    u.join_date,
    COUNT(o.order_id) AS orders_in_2019
FROM 
    Users u
LEFT JOIN 
    Orders o ON u.user_id = o.buyer_id AND YEAR(o.order_date) = 2019
GROUP BY 
    u.user_id, u.join_date;
```

### Explanation:
1. **SELECT Statement**: We're selecting the `user_id` as `buyer_id`, the `join_date`, and counting the `order_id` from the `Orders` table.
  
2. **FROM Clause**: We start from the `Users` table (aliased as `u`).

3. **LEFT JOIN**: We perform a LEFT JOIN on the `Orders` table (aliased as `o`) to ensure that all users are included, even those who did not make any orders.

4. **Join Condition**: We join on `buyer_id` matching `user_id`, and also filter for orders that occurred in 2019 using `YEAR(o.order_date) = 2019`.

5. **GROUP BY Clause**: We group by `u.user_id` and `u.join_date` to aggregate the results properly for each user.

### Result:
The query will return a result table containing each user's ID, their join date, and the count of orders they made as a buyer in 2019. Users without any orders in that year will show a count of zero.