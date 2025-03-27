To categorize and count the number of bank accounts based on their income into predefined salary categories, you can follow these steps:

### Problem Breakdown

1. **Categorize Income**:
   - Assign each account to one of three salary categories based on their income:
     - "Low Salary": Income strictly less than $20,000.
     - "Average Salary": Income between $20,000 and $50,000 (inclusive).
     - "High Salary": Income strictly greater than $50,000.

2. **Count Accounts in Each Category**:
   - Compute the number of accounts in each category.

3. **Handle Categories with Zero Accounts**:
   - Ensure that each salary category is represented in the result, even if there are no accounts in that category.

### SQL Solution

Here is a SQL query to achieve the desired result:

```sql
WITH CategoryCounts AS (
    SELECT
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            ELSE 'High Salary'
        END AS category
    FROM Accounts
),
CategoryList AS (
    SELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'High Salary'
)
SELECT
    cl.category,
    COALESCE(COUNT(cc.category), 0) AS accounts_count
FROM CategoryList cl
LEFT JOIN CategoryCounts cc
ON cl.category = cc.category
GROUP BY cl.category
ORDER BY cl.category;
```

### Explanation

1. **CategoryCounts CTE**:
   - **Purpose**: Categorizes each account based on the income.
   - **Query**:
     ```sql
     WITH CategoryCounts AS (
         SELECT
             CASE
                 WHEN income < 20000 THEN 'Low Salary'
                 WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
                 ELSE 'High Salary'
             END AS category
         FROM Accounts
     )
     ```
   - **Explanation**: The `CASE` statement assigns a salary category to each account based on its income.

2. **CategoryList CTE**:
   - **Purpose**: Creates a list of all possible categories to ensure each category is represented in the final result.
   - **Query**:
     ```sql
     CategoryList AS (
         SELECT 'Low Salary' AS category
         UNION ALL
         SELECT 'Average Salary'
         UNION ALL
         SELECT 'High Salary'
     )
     ```
   - **Explanation**: Defines the categories of interest.

3. **Final Query**:
   - **Purpose**: Joins the categories with the categorized accounts and counts the number of accounts per category.
   - **Query**:
     ```sql
     SELECT
         cl.category,
         COALESCE(COUNT(cc.category), 0) AS accounts_count
     FROM CategoryList cl
     LEFT JOIN CategoryCounts cc
     ON cl.category = cc.category
     GROUP BY cl.category
     ORDER BY cl.category;
     ```
   - **Explanation**:
     - `LEFT JOIN`: Ensures that all categories from `CategoryList` are included, even if there are no corresponding accounts in `CategoryCounts`.
     - `COALESCE(COUNT(cc.category), 0)`: Counts the number of accounts in each category. If no accounts exist for a category, it defaults to 0.
     - `GROUP BY cl.category`: Groups the results by category.
     - `ORDER BY cl.category`: Orders the results alphabetically by category name.

### Example

Given the `Accounts` table:

```sql
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+
```

**Output**:

```sql
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+
```

- **Low Salary**: Account 2 with an income of 12,747.
- **Average Salary**: No accounts fall into this category.
- **High Salary**: Accounts 3, 6, and 8 with incomes greater than 50,000. 

This query ensures that all categories are represented, and accounts are counted according to the specified salary ranges.