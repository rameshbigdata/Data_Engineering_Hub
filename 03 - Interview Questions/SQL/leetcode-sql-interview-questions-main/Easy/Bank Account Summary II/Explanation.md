To solve this problem, we need to calculate the balance of each user based on their account and transactions. Then, we will filter out users whose balance is greater than 10,000.

### Steps to solve the problem:
1. **Join the `Users` and `Transactions` tables** based on the `account` column to connect each user's name with their transactions.
2. **Group the transactions by account** and sum the `amount` for each account to get the balance.
3. **Filter the results** to show only users whose balance is greater than 10,000.
4. **Return the user's name and balance.**

Here’s the SQL query to achieve this:

```sql
SELECT u.name, SUM(t.amount) AS balance
FROM Users u
JOIN Transactions t
ON u.account = t.account
GROUP BY u.name
HAVING SUM(t.amount) > 10000;
```

### Explanation of the query:
- `JOIN Users u ON u.account = t.account`: We join the `Users` table with the `Transactions` table using the `account` column to get the user information (like name) and their respective transactions.
- `GROUP BY u.name`: After joining, we group the result by the user's name to compute the balance for each user.
- `SUM(t.amount)`: For each account, we sum the `amount` from the `Transactions` table to get the total balance.
- `HAVING SUM(t.amount) > 10000`: We use `HAVING` to filter out users whose total balance is more than 10,000.

This query will return the `name` and `balance` for each user with a balance greater than 10,000.