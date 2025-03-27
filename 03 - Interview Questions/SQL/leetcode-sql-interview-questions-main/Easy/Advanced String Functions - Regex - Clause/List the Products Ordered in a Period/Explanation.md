### Problem Explanation:

You have two tables:
1. **Products**: Contains product information.
2. **Orders**: Contains order information, with each order linked to a product and a specific order date.

You need to:
1. Identify products that were ordered at least 100 units in February 2020.
2. Return the names of these products along with the total units ordered.

### Example:

#### Input:
**Products table**:

```
| product_id | product_name          | product_category |
|------------|-----------------------|------------------|
| 1          | Leetcode Solutions    | Book             |
| 2          | Jewels of Stringology | Book             |
| 3          | HP                    | Laptop           |
| 4          | Lenovo                | Laptop           |
| 5          | Leetcode Kit          | T-shirt          |
```

**Orders table**:

```
| product_id | order_date | unit |
|------------|------------|------|
| 1          | 2020-02-05 | 60   |
| 1          | 2020-02-10 | 70   |
| 2          | 2020-01-18 | 30   |
| 2          | 2020-02-11 | 80   |
| 3          | 2020-02-17 | 2    |
| 3          | 2020-02-24 | 3    |
| 4          | 2020-03-01 | 20   |
| 4          | 2020-03-04 | 30   |
| 4          | 2020-03-04 | 60   |
| 5          | 2020-02-25 | 50   |
| 5          | 2020-02-27 | 50   |
| 5          | 2020-03-01 | 50   |
```

#### Output:

```
| product_name       | unit |
|--------------------|------|
| Leetcode Solutions | 130  |
| Leetcode Kit       | 100  |
```

### Explanation:

- **Leetcode Solutions**: Ordered 60 units on 2020-02-05 and 70 units on 2020-02-10, totaling 130 units in February.
- **Jewels of Stringology**: Ordered 80 units on 2020-02-11, totaling 80 units in February (not included as it's less than 100 units).
- **HP**: Ordered 2 units on 2020-02-17 and 3 units on 2020-02-24, totaling 5 units in February (not included).
- **Lenovo**: Not ordered in February.
- **Leetcode Kit**: Ordered 50 units on 2020-02-25 and 50 units on 2020-02-27, totaling 100 units in February.

### Solution Approach:

1. **Join** the `Products` and `Orders` tables on `product_id`.
2. **Filter** for orders that were placed in February 2020.
3. **Group By** `product_name` and sum the total units ordered.
4. **Filter** to include only those products with a total of 100 or more units.
5. **Select** the `product_name` and the sum of units.

### SQL Query:

```sql
SELECT
    p.product_name,
    SUM(o.unit) AS unit
FROM
    Orders o
JOIN
    Products p ON o.product_id = p.product_id
WHERE
    o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY
    p.product_name
HAVING
    SUM(o.unit) >= 100;
```

### Explanation of the Query:

1. **SELECT**:
   - `p.product_name`: The name of the product.
   - `SUM(o.unit) AS unit`: The total number of units ordered in February 2020.

2. **FROM Orders o JOIN Products p ON o.product_id = p.product_id**:
   - Join the `Orders` and `Products` tables to match each order with its product details.

3. **WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'**:
   - Filter the orders to include only those that occurred in February 2020.

4. **GROUP BY p.product_name**:
   - Aggregate results by `product_name`.

5. **HAVING SUM(o.unit) >= 100**:
   - Include only those products with a total of 100 or more units ordered.

This query ensures that only products ordered in sufficient quantity (100 or more units) in February 2020 are included in the result.