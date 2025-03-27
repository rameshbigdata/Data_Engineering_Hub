### Problem Explanation

You are given a table named `Teacher` which provides information about which subjects each teacher teaches in which department. The table has the following columns:

- `teacher_id`: An identifier for the teacher.
- `subject_id`: An identifier for the subject being taught.
- `dept_id`: An identifier for the department where the subject is taught.

Each row in the table signifies that a particular teacher (`teacher_id`) teaches a specific subject (`subject_id`) in a given department (`dept_id`). Note that a teacher might teach the same subject in different departments, and this should be considered as only one unique subject for that teacher.

The task is to calculate the number of unique subjects that each teacher teaches across all departments and return the result showing the `teacher_id` and the count of unique subjects they teach.

### Solution Explanation

To solve this problem, we need to count the number of unique subjects each teacher is teaching. Here’s the step-by-step approach to achieve this:

1. **Group by Teacher**: We need to aggregate the data by `teacher_id` because we want the count of unique subjects per teacher.

2. **Count Distinct Subjects**: For each teacher, count the distinct `subject_id` values. This ensures that if a teacher is teaching the same subject in multiple departments, it is only counted once.

3. **SQL Query**:
   - Use the `COUNT(DISTINCT subject_id)` function to count the number of unique subjects each teacher teaches.
   - Use `GROUP BY teacher_id` to aggregate the counts per teacher.

Here is the SQL query that accomplishes this:

```sql
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;
```

**Explanation of the Query**:
- `SELECT teacher_id`: This specifies that we want to include the `teacher_id` in the result.
- `COUNT(DISTINCT subject_id) AS cnt`: This counts the number of distinct subjects (`subject_id`) each teacher teaches and labels the result as `cnt`.
- `FROM Teacher`: Indicates the table from which to retrieve the data.
- `GROUP BY teacher_id`: Groups the results by `teacher_id`, so that the `COUNT(DISTINCT subject_id)` is calculated for each teacher individually.

This query will return a table where each row represents a teacher and the count of unique subjects they are teaching.