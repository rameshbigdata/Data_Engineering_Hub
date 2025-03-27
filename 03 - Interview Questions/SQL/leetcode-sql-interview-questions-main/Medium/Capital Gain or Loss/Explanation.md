The problem involves calculating the capital gain or loss for various stocks based on their buy and sell operations recorded in a database table. Each stock has a name, an operation type (either "Buy" or "Sell"), the day of the operation, and the price at which the operation occurred.

### Problem Breakdown

1. **Table Structure**: 
   - The `Stocks` table contains:
     - `stock_name`: The name of the stock.
     - `operation`: Either 'Buy' or 'Sell'.
     - `operation_day`: The day when the operation took place.
     - `price`: The price of the stock during that operation.

2. **Constraints**:
   - Every 'Sell' operation has a corresponding 'Buy' operation before it, and every 'Buy' operation has a corresponding 'Sell' operation after it. This guarantees that we can always match buys and sells.

3. **Capital Gain/Loss Calculation**:
   - Capital gain/loss for a stock is calculated as:
     - For each pair of 'Buy' and 'Sell' operations, the gain/loss is the difference between the selling price and the buying price.
   - The overall capital gain/loss is the sum of all individual gains/losses for that stock.

### Solution Explanation

The provided SQL solution utilizes a Common Table Expression (CTE) and a self-join to calculate the total capital gain/loss for each stock. Here's how it works:

1. **CTE Creation**:
   - A CTE is created to assign a row number to each operation (either 'Buy' or 'Sell') for each stock, ordered by `operation_day`. This helps to identify which 'Buy' corresponds to which 'Sell'.

   ```sql
   WITH CTE AS (
       SELECT 
           stock_name,
           operation,
           operation_day,
           price,
           ROW_NUMBER() OVER (PARTITION BY stock_name, operation ORDER BY operation_day) AS rn
       FROM 
           Stocks
   )
   ```

2. **Self-Join**:
   - The CTE is then self-joined to associate each 'Buy' operation with its corresponding 'Sell' operation using the row number `rn` to ensure they are paired correctly.

   ```sql
   JOIN CTE s ON b.stock_name = s.stock_name AND b.rn = s.rn
   ```

3. **Calculating Gains/Losses**:
   - The difference between the selling price and the buying price is computed in the `SELECT` statement.

   ```sql
   SUM(s.price - b.price) AS capital_gain_loss
   ```

4. **Grouping Results**:
   - Finally, the results are grouped by `stock_name` to summarize the total capital gain/loss for each stock.

   ```sql
   GROUP BY b.stock_name;
   ```

### Result
The output consists of a table listing each stock and its corresponding capital gain/loss, which could be positive (gain) or negative (loss). The result is presented in any order, as specified in the problem.

This SQL query effectively aggregates and computes the necessary financial information based on the structured data provided in the `Stocks` table.