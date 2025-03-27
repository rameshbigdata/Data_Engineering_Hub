The SQL query provided is designed to calculate the number of times each student attended each exam, including cases where a student did not attend certain exams. Here's a detailed explanation of how the query achieves this:

### Query Breakdown

```sql
SELECT 
    s.student_id, 
    s.student_name, 
    sub.subject_name, 
    COALESCE(COUNT(e.subject_name), 0) AS attended_exams
FROM 
    Students s
CROSS JOIN 
    Subjects sub
LEFT JOIN 
    Examinations e 
    ON s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id, s.student_name, sub.subject_name
ORDER BY 
    s.student_id, sub.subject_name;
```

#### Components of the Query:

1. **`SELECT` Clause:**
   - `s.student_id`: The ID of the student.
   - `s.student_name`: The name of the student.
   - `sub.subject_name`: The name of the subject.
   - `COALESCE(COUNT(e.subject_name), 0) AS attended_exams`: Counts the number of times a student attended a particular exam. The `COALESCE` function ensures that if there are no matching records in the `Examinations` table, the count is set to 0.

2. **`FROM Students s`**
   - This specifies that the query starts with the `Students` table.

3. **`CROSS JOIN Subjects sub`**
   - This creates a Cartesian product between the `Students` and `Subjects` tables. Every student is paired with every subject, ensuring that the final result includes all possible combinations of students and subjects.

4. **`LEFT JOIN Examinations e ON s.student_id = e.student_id AND sub.subject_name = e.subject_name`**
   - This performs a LEFT JOIN with the `Examinations` table to include the count of exams attended by each student for each subject. The `LEFT JOIN` ensures that even if a student has not attended any exams for a particular subject, that combination will still be included with a count of 0.

5. **`GROUP BY s.student_id, s.student_name, sub.subject_name`**
   - This groups the results by student and subject, allowing the `COUNT` function to compute the number of attended exams for each combination.

6. **`ORDER BY s.student_id, sub.subject_name`**
   - This orders the final results first by `student_id` and then by `subject_name` to ensure the output is sorted appropriately.
