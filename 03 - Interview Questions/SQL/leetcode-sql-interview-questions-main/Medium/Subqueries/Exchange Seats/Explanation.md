### Problem Statement

You have a table called `Seat` with the following columns:

- `id`: An integer representing the unique seat ID of a student. The sequence of IDs starts from 1 and increments continuously.
- `student`: The name of the student sitting in that seat.

**Task**: Swap the seat IDs of every two consecutive students. If the number of students is odd, the ID of the last student should not be swapped.

### Example

#### Input:

```sql
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
```

#### Desired Output:

```sql
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
```

**Explanation**:

1. **Swap IDs**:
   - Students in seat `1` (Abbot) and seat `2` (Doris) swap their seats. 
   - Students in seat `3` (Emerson) and seat `4` (Green) swap their seats.
   - The student in seat `5` (Jeames) remains in their seat because there’s no one to swap with (since the number of students is odd).

### Solution

To achieve the desired output, you need to create a query that:

1. **Identifies Pairs to Swap**:
   - For every pair of consecutive seats, swap their IDs.
   - If an ID is odd and has a next seat (even ID), it should swap with that next seat.

2. **Maintains Order**:
   - After swapping, order the results by the new IDs.

### SQL Query Explanation

Here is the query to accomplish the above:

```sql
SELECT 
    CASE 
        WHEN MOD(id, 2) = 1 AND id < (SELECT MAX(id) FROM Seat)
        THEN id + 1
        WHEN MOD(id, 2) = 0 AND id > 1
        THEN id - 1
        ELSE id
    END AS id,
    student
FROM Seat
ORDER BY id;
```

**Breakdown**:

1. **`CASE` Statement**:
   - **`WHEN MOD(id, 2) = 1 AND id < (SELECT MAX(id) FROM Seat)`**: 
     - This condition checks if the `id` is odd and if it is not the last `id`. If true, it means this student should swap seats with the next one (i.e., `id + 1`).
   - **`WHEN MOD(id, 2) = 0 AND id > 1`**:
     - This condition checks if the `id` is even and not the first one. If true, this student should swap seats with the previous one (i.e., `id - 1`).
   - **`ELSE id`**:
     - This handles the cases where the `id` does not meet the above conditions, such as the last student (odd `id` with no pair) or the first student in the list.

2. **Ordering**:
   - **`ORDER BY id`**:
     - After computing the new seat `id` values, this orders the results by `id` to reflect the updated seat arrangement.

### Conclusion

This query efficiently swaps the seat IDs for every two consecutive students while keeping the seat ID of the last student unchanged if the total number of students is odd. The use of the `CASE` statement helps conditionally compute the new seat IDs based on whether they are odd or even and whether they are at the end of the list.