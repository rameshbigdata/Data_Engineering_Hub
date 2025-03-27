### Problem Explanation

You are provided with two tables: `Sales` and `Product`. Your goal is to find, for each product, the information from the first year it was sold. Specifically, for each product, you need to return the `product_id`, the first year of sales (`first_year`), the `quantity` sold in that first year, and the `price` per unit in that first year.

### Solution Explanation

To solve this problem, follow these steps:

1. **Find the First Year for Each Product**: 
   - Use the `MIN()` function to find the earliest (`first_year`) that each product was sold.
   
2. **Join with the Sales Data**: 
   - Once you have the first year for each product, join this result back to the `Sales` table to get the corresponding `quantity` and `price` for that year.

Here is how the solution can be written in SQL:

```sql
WITH FirstYear AS (
    SELECT 
        product_id, 
        MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
)

SELECT 
    s.product_id, 
    f.first_year AS first_year, 
    s.quantity, 
    s.price
FROM Sales s
JOIN FirstYear f
    ON s.product_id = f.product_id
    AND s.year = f.first_year;
```

### Explanation of the Query

1. **CTE `FirstYear`**:
   - `SELECT product_id, MIN(year) AS first_year`: This part selects the `product_id` and calculates the earliest year (`first_year`) that the product was sold using the `MIN()` function.
   - `FROM Sales`: This specifies that the data is being selected from the `Sales` table.
   - `GROUP BY product_id`: This groups the data by `product_id` so that the `MIN(year)` can be calculated for each product.

2. **Main Query**:
   - `SELECT s.product_id, f.first_year AS first_year, s.quantity, s.price`: In this part, we select the product ID, the first year of sales, the quantity sold, and the price for that first year.
   - `FROM Sales s JOIN FirstYear f`: Here, we join the `Sales` table (aliased as `s`) with the `FirstYear` CTE (aliased as `f`).
   - `ON s.product_id = f.product_id AND s.year = f.first_year`: The join condition ensures that we only retrieve rows from the `Sales` table where the year matches the earliest year (`first_year`) for that product.

This query returns a table with the `product_id`, `first_year`, `quantity`, and `price` for each product in its first year of sales. 

### Example Walkthrough

Given the input:

**Sales table**:
```
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+
```

**Product table**:
```
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+
```

**Output**:
```
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+
``` 

For product `100`, the first year it was sold is `2008`, with a quantity of `10` and a price of `5000`. Similarly, for product `200`, the first year it was sold is `2011`, with a quantity of `15` and a price of `9000`.