### Problem Explanation:

You are given a table called `Activities` with the following columns:
- `sell_date`: A date when a product was sold.
- `product`: The name of the product sold.

Your task is to:
1. Find the number of different products sold for each date.
2. List the names of these products sorted lexicographically.
3. Return the results ordered by `sell_date`.

### Example:

#### Input:
The `Activities` table looks like this:
```
| sell_date  | product     |
|------------|-------------|
| 2020-05-30 | Headphone   |
| 2020-06-01 | Pencil      |
| 2020-06-02 | Mask        |
| 2020-05-30 | Basketball  |
| 2020-06-01 | Bible       |
| 2020-06-02 | Mask        |
| 2020-05-30 | T-Shirt     |
```
#### Output:
The expected output is:
```
| sell_date  | num_sold | products                     |
|------------|----------|------------------------------|
| 2020-05-30 | 3        | Basketball,Headphone,T-Shirt |
| 2020-06-01 | 2        | Bible,Pencil                 |
| 2020-06-02 | 1        | Mask                         |
```
### Explanation:

- For `2020-05-30`, the products are `Headphone`, `Basketball`, and `T-Shirt`. After sorting them lexicographically, they should be concatenated with commas.
- For `2020-06-01`, the products are `Pencil` and `Bible`. After sorting, they should be concatenated with commas.
- For `2020-06-02`, the product is `Mask`, so it should be returned as is.

### Solution Approach:

To solve this problem, you need to:
1. **Count the number of distinct products** sold on each date.
2. **Concatenate** the names of these products into a single string, sorted lexicographically.
3. **Order** the results by `sell_date`.

### SQL Query:

Here’s how you can achieve this in SQL:

```sql
SELECT
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product ASC SEPARATOR ',') AS products
FROM
    Activities
GROUP BY
    sell_date
ORDER BY
    sell_date;
```

### Explanation of the Query:

1. **SELECT**:
   - `sell_date`: The date of the sale.
   - `COUNT(DISTINCT product) AS num_sold`: Counts the number of unique products sold on that date.
   - `GROUP_CONCAT(DISTINCT product ORDER BY product ASC SEPARATOR ',') AS products`: Concatenates the unique product names for each date, sorted lexicographically, separated by commas.

2. **FROM Activities**: We are querying from the `Activities` table.

3. **GROUP BY sell_date**: Groups the results by `sell_date` so that aggregation functions can be applied for each date.

4. **ORDER BY sell_date**: Orders the final result by `sell_date` to ensure that the dates are in ascending order.

### Output:

For the given `Activities` table:
```
| sell_date  | num_sold | products                     |
|------------|----------|------------------------------|
| 2020-05-30 | 3        | Basketball,Headphone,T-Shirt |
| 2020-06-01 | 2        | Bible,Pencil                 |
| 2020-06-02 | 1        | Mask                         |
```
This SQL query provides the required result where each date is associated with the number of distinct products sold and a lexicographically sorted list of these products.