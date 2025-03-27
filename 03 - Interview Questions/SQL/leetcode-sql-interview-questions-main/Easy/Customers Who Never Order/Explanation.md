To find all customers who never placed an order, you can use a SQL `LEFT JOIN` to join the `Customers` table with the `Orders` table. Then, filter out the rows where there is no corresponding order.

Here’s the SQL query to achieve that:

```sql
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.customerId IS NULL;
```

### Explanation:

1. **`LEFT JOIN`**: This join type is used to include all rows from the `Customers` table and the matched rows from the `Orders` table. If there is no match, the result is `NULL` for the `Orders` columns.

2. **`WHERE o.customerId IS NULL`**: This condition filters the results to only include customers who do not have any matching records in the `Orders` table, meaning they have never placed an order.

### Example with Provided Data

Given the `Customers` table:

```
| id | name  |
|----|-------|
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
```

And the `Orders` table:

```
| id | customerId |
|----|------------|
| 1  | 3          |
| 2  | 1          |
```

The query will return:

```
| Customers |
|-----------|
| Henry     |
| Max       |
```

This output shows customers who have no orders associated with their ID.