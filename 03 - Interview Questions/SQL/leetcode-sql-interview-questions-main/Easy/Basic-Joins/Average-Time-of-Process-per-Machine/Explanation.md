### Step-by-Step Explanation

1. **Subquery: `ProcessTimes`**

   ```sql
   SELECT 
       machine_id, 
       MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time, 
       MAX(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time
   FROM Activity
   GROUP BY machine_id, process_id
   ```

   - **Purpose:** This subquery computes the start and end times for each process on each machine.
   - **`MAX(CASE WHEN ...)`:** This construction is used to pivot the data from rows into columns. For each `process_id` and `machine_id` combination, it extracts the `timestamp` of the 'start' and 'end' activities:
     - `MAX(CASE WHEN activity_type = 'start' THEN timestamp END)` finds the start timestamp for the process.
     - `MAX(CASE WHEN activity_type = 'end' THEN timestamp END)` finds the end timestamp for the process.
   - **`GROUP BY machine_id, process_id`:** This groups the records by `machine_id` and `process_id` to ensure we get the start and end times for each process.

2. **Outer Query: Calculating Average Processing Time**

   ```sql
   SELECT 
       machine_id, 
       ROUND(AVG(end_time - start_time), 3) AS processing_time
   FROM (
       -- Subquery goes here
   ) AS ProcessTimes
   GROUP BY machine_id
   ```

   - **`AVG(end_time - start_time)`:** Calculates the average time taken to complete each process for each machine. This is done by computing the difference between `end_time` and `start_time` for each process, then averaging these differences.
   - **`ROUND(..., 3)`:** Rounds the average processing time to three decimal places for better readability and precision.
   - **`GROUP BY machine_id`:** This groups the results by `machine_id` to compute the average processing time per machine.

### Example Execution

Given the example data:

- **For `machine_id = 0`:**
  - Processes:
    - Process 0: Start at 0.712, End at 1.520 (Duration = 1.520 - 0.712 = 0.808)
    - Process 1: Start at 3.140, End at 4.120 (Duration = 4.120 - 3.140 = 0.980)
  - Average Time: `(0.808 + 0.980) / 2 = 0.894`

- **For `machine_id = 1`:**
  - Processes:
    - Process 0: Start at 0.550, End at 1.550 (Duration = 1.550 - 0.550 = 1.000)
    - Process 1: Start at 0.430, End at 1.420 (Duration = 1.420 - 0.430 = 0.990)
  - Average Time: `(1.000 + 0.990) / 2 = 0.995`

- **For `machine_id = 2`:**
  - Processes:
    - Process 0: Start at 4.100, End at 4.512 (Duration = 4.512 - 4.100 = 0.412)
    - Process 1: Start at 2.500, End at 5.000 (Duration = 5.000 - 2.500 = 2.500)
  - Average Time: `(0.412 + 2.500) / 2 = 1.456`
