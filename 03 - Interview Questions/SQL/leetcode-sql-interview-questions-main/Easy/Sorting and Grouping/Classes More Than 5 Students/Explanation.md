### Problem Explanation

You are given a table named `Courses` which records the enrollment of students in different classes. Each row represents a unique combination of a student and a class. Your task is to find all classes that have at least five students enrolled.

### Solution Explanation

To solve this problem, you need to determine which classes have a minimum of five students enrolled. The approach involves:

1. **Grouping by Class**: Aggregate the data by `class` to count how many students are enrolled in each class.

2. **Counting Students**: Use the `COUNT` function to count the number of students in each class.

3. **Filtering Classes**: Use the `HAVING` clause to filter out classes that have fewer than five students.

Here’s the SQL query to achieve this:

```sql
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
```

**Explanation of the Query**:

1. **`SELECT class`**: This selects the `class` column which will be included in the final result.

2. **`FROM Courses`**: Specifies the table from which to retrieve the data.

3. **`GROUP BY class`**: Groups the rows by the `class` column. This is necessary to aggregate the data by each class.

4. **`HAVING COUNT(student) >= 5`**: Filters the grouped results to include only those classes where the count of students is at least five. The `HAVING` clause is used for filtering groups after aggregation (unlike `WHERE`, which filters rows before aggregation).

This query will return a list of classes where the number of enrolled students is five or more. The result table will contain one column (`class`) and will list the classes that meet the criteria.