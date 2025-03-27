To solve the problem, you need to identify authors who have viewed at least one of their own articles. 

Here's a brief explanation of the SQL query:

1. **SELECT DISTINCT author_id AS id**: This selects unique author IDs from the table, renaming `author_id` as `id`.

2. **FROM Views**: Specifies the source table.

3. **WHERE author_id = viewer_id**: Filters the results to include only rows where the `author_id` is the same as the `viewer_id`, meaning the author viewed their own article.

4. **ORDER BY author_id**: Sorts the results by `author_id` in ascending order.

In essence, the query finds all authors who have viewed their own articles and lists them, sorted by their IDs.