### Problem Explanation

You have a table called `Scores` that records game scores along with their unique identifiers. The objective is to assign a rank to each score based on its value, following specific rules:

1. **Ranking Order**: Higher scores should have a lower (better) rank number (i.e., rank 1 is the highest).
2. **Handling Ties**: If two or more scores are identical, they should share the same rank.
3. **Consecutive Ranks**: After a tie, the next rank should be the next integer (no gaps).

### Solution Explanation

To solve this problem, we can use SQL, specifically a window function called `DENSE_RANK()`. This function allows us to assign ranks while respecting the rules laid out. Here’s how the solution works:

1. **Select the Required Columns**: We need to select the `score` from the `Scores` table.
  
2. **Apply DENSE_RANK()**:
   - Use the `DENSE_RANK()` function to assign ranks to scores ordered by the `score` column in descending order (`ORDER BY score DESC`).
   - This function will give the same rank to identical scores, and the next distinct score will receive the next consecutive rank.

3. **Order the Output**: The result should be ordered by the `score` in descending order.

Here is the SQL query:

```sql
SELECT
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM Scores
ORDER BY score DESC;
```

### Breakdown of the Query

- **SELECT score**: This fetches the score values from the table.
- **DENSE_RANK() OVER (ORDER BY score DESC)**: This computes the rank based on the descending order of scores. The `DENSE_RANK()` ensures that tied scores get the same rank without skipping any rank numbers.
- **FROM Scores**: This indicates that we're querying from the `Scores` table.
- **ORDER BY score DESC**: This arranges the final output by score in descending order.

### Example Walkthrough

Given the input table:

```
+----+-------+
| id | score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
```

The ranks will be assigned as follows:

- Scores of `4.00` (id 3 and 5) both get rank 1.
- Score of `3.85` (id 4) gets rank 2.
- Scores of `3.65` (id 2 and 6) get rank 3.
- Score of `3.50` (id 1) gets rank 4.

The final output will be:

```
+-------+------+
| score | rank |
+-------+------+
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |
+-------+------+
```

This output meets all the specified ranking requirements.