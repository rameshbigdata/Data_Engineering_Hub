To determine the type of each node in the tree, we can analyze the relationships between nodes based on the `id` and `p_id` columns. We'll categorize each node as "Root," "Inner," or "Leaf" based on the following criteria:

- **Root**: A node with no parent (i.e., `p_id` is `null`).
- **Inner**: A node that has a parent and also has children.
- **Leaf**: A node that has a parent but does not have any children.

Here’s how we can achieve this using SQL:

1. First, identify the root node(s) by checking for `null` in the `p_id` column.
2. Next, identify the inner nodes by checking which nodes have children.
3. Finally, classify the remaining nodes as leaf nodes.

Here’s the SQL query that implements this logic:

```sql
SELECT 
    id,
    CASE 
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM 
    Tree;
```

### Explanation of the SQL Query:

1. **Selecting `id`**: We select the `id` of each node.
2. **CASE Statement**:
   - **WHEN `p_id IS NULL`**: If the `p_id` is `null`, then the node is a Root.
   - **WHEN `id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL)`**: This checks if the `id` exists in the list of parent IDs (`p_id`) in the table, which indicates the node has children, making it an Inner node.
   - **ELSE**: If neither of the above conditions is met, then the node is classified as a Leaf.

### Sample Output:
For the given example input, the query will produce the following output:

```
| id | type  |
|----|-------|
| 1  | Root  |
| 2  | Inner |
| 3  | Leaf  |
| 4  | Leaf  |
| 5  | Leaf  |
```

This solution will correctly classify each node based on its relationships in the tree structure.