# Step 1: Identify the First Orders

```sql
WITH FirstOrders AS (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
)
```

- **Purpose**: This Common Table Expression (CTE) identifies the earliest order date (`first_order_date`) for each customer.
- **Explanation**: 
  - `MIN(order_date)`: Finds the earliest order date for each customer.
  - `GROUP BY customer_id`: Groups the results by `customer_id` to ensure that each customer’s first order date is calculated.

### Step 2: Retrieve Details of First Orders

```sql
CustomerFirstOrders AS (
    SELECT d.delivery_id, d.customer_id, d.order_date, d.customer_pref_delivery_date
    FROM Delivery d
    JOIN FirstOrders fo
    ON d.customer_id = fo.customer_id AND d.order_date = fo.first_order_date
)
```

- **Purpose**: This CTE joins the `Delivery` table with the results from `FirstOrders` to get the details of each customer's first order.
- **Explanation**:
  - The `JOIN` ensures that only the orders with the earliest dates (first orders) for each customer are selected.
  - It matches records from the `Delivery` table with the `FirstOrders` CTE based on both `customer_id` and `order_date`.

### Step 3: Calculate the Percentage of Immediate First Orders

```sql
SELECT ROUND(100.0 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) 
             / COUNT(*), 2) AS immediate_percentage
FROM CustomerFirstOrders;
```

- **Purpose**: This query calculates the percentage of immediate orders among the first orders of all customers.
- **Explanation**:
  - `CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END`: Checks if the `order_date` is the same as the `customer_pref_delivery_date`. If they are the same, it counts as `1` (immediate order), otherwise `0`.
  - `SUM(...)`: Sums up all the `1`s to get the total count of immediate first orders.
  - `COUNT(*)`: Counts the total number of first orders.
  - `ROUND(100.0 * ... / COUNT(*), 2)`: Calculates the percentage of immediate first orders by dividing the count of immediate orders by the total number of first orders and multiplying by 100. The `ROUND` function rounds the result to 2 decimal places.

### Example

Given the example data:
- Customer 1’s first order is on 2019-08-01, and it’s scheduled.
- Customer 2’s first order is on 2019-08-02, and it’s immediate.
- Customer 3’s first order is on 2019-08-21, and it’s scheduled.
- Customer 4’s first order is on 2019-08-09, and it’s immediate.

There are 2 immediate first orders out of 4 total first orders. The calculation for the percentage would be:

\[ \text{Percentage} = \left( \frac{2}{4} \right) \times 100 = 50.00\% \]

So, the final output is `50.00`, representing the percentage of immediate first orders rounded to two decimal places.