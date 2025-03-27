To solve the problem of reporting the product name, year, and price for each sale, you can use an SQL `JOIN` operation to combine information from the `Sales` and `Product` tables. 

### Problem Breakdown

1. **Tables Involved:**
   - **Sales:** Contains details about sales transactions. Each row includes `sale_id`, `product_id`, `year`, `quantity`, and `price`.
   - **Product:** Contains product information. Each row includes `product_id` and `product_name`.

2. **Objective:**
   - For each sale record in the `Sales` table, retrieve the corresponding `product_name` from the `Product` table along with the `year` and `price` of the sale.

### SQL Query Explanation

```sql
SELECT Product.product_name, Sales.year, Sales.price 
FROM Sales
JOIN Product 
ON Sales.product_id = Product.product_id;
```

#### Components of the Query

1. **SELECT Clause:**
   - `Product.product_name`: This selects the `product_name` from the `Product` table.
   - `Sales.year`: This selects the `year` from the `Sales` table.
   - `Sales.price`: This selects the `price` from the `Sales` table.

2. **FROM Clause:**
   - `Sales`: This is the primary table from which the query starts.

3. **JOIN Clause:**
   - `JOIN Product ON Sales.product_id = Product.product_id`: This performs an inner join between the `Sales` table and the `Product` table based on the `product_id` column.
     - **Inner Join:** The join combines rows from both tables where the `product_id` matches.
     - `Sales.product_id = Product.product_id`: This specifies the condition for the join, i.e., matching `product_id` in both tables.

#### How It Works

- **Matching Rows:**
  - The `JOIN` operation matches rows from the `Sales` table with rows from the `Product` table based on the `product_id`.
  - For each sale record, the query finds the corresponding product name from the `Product` table.

- **Output:**
  - The result will include the product name, sale year, and price for each record in the `Sales` table.
  - Each sale record is displayed with the product name and price as per the joined `Product` and `Sales` tables.

### Example

Given the input tables:

**Sales Table:**

```
| sale_id | product_id | year | quantity | price |
|---------|------------|------|----------|-------|
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
```

**Product Table:**

```
| product_id | product_name |
|------------|--------------|
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
```

The query will return:

```
| product_name | year | price |
|--------------|------|-------|
| Nokia        | 2008 | 5000  |
| Nokia        | 2009 | 5000  |
| Apple        | 2011 | 9000  |
```

Here:
- For `sale_id` 1 and 2, the product is Nokia, sold for 5000 in years 2008 and 2009 respectively.
- For `sale_id` 7, the product is Apple, sold for 9000 in the year 2011.
