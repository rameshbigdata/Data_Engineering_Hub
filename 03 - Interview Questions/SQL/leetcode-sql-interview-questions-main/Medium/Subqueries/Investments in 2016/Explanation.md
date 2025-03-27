To solve the problem of finding the sum of `tiv_2016` for policyholders who meet specific criteria, we'll follow these steps:

1. **Identify `tiv_2015` Values That Appear More Than Once:** We need to find `tiv_2015` values that are shared by more than one policyholder. This ensures that we're considering policyholders who have the same `tiv_2015` value as others.

2. **Filter Policyholders with Unique Locations:** We then need to ensure that the policyholders are located in cities with unique coordinates. This means we should filter out policyholders whose `lat` and `lon` combination is shared with other policyholders.

3. **Combine the Two Conditions:** We will join the results from the first two steps to identify policyholders who both have duplicate `tiv_2015` values and unique locations.

4. **Sum and Round `tiv_2016`:** Finally, compute the sum of `tiv_2016` for these policyholders and round the result to two decimal places.

### Detailed Solution

Here's how you can achieve this in SQL:

```sql
-- Step 1: Identify tiv_2015 values that appear more than once
WITH DuplicateTiv2015 AS (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
),

-- Step 2: Filter policyholders with unique locations
UniqueLocations AS (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
),

-- Step 3: Select policyholders who meet both criteria
ValidPolicies AS (
    SELECT i.pid, i.tiv_2016
    FROM Insurance i
    JOIN DuplicateTiv2015 d ON i.tiv_2015 = d.tiv_2015
    JOIN UniqueLocations u ON i.lat = u.lat AND i.lon = u.lon
)

-- Step 4: Calculate the sum of tiv_2016 and round to 2 decimal places
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM ValidPolicies;
```

### Explanation of Each Step

1. **`DuplicateTiv2015`:**
   - This CTE (Common Table Expression) groups the records by `tiv_2015` and selects those values that appear more than once. This helps in identifying `tiv_2015` values that are shared among multiple policyholders.

2. **`UniqueLocations`:**
   - This CTE groups the records by `lat` and `lon` and selects those coordinate pairs that are unique (i.e., appear only once). This ensures that we are considering only policyholders located in unique cities.

3. **`ValidPolicies`:**
   - This CTE joins the `Insurance` table with the results from the first two CTEs to find policyholders who both have a duplicate `tiv_2015` value and a unique location. 

4. **Final Calculation:**
   - The final query calculates the sum of `tiv_2016` for these filtered policyholders and rounds the result to two decimal places.
