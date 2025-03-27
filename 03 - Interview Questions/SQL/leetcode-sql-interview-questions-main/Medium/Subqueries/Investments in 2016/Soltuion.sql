-- Step 1: Identify tiv_2015 values that appear more than once
WITH DuplicateTiv2015 AS (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
),

-- Step 2: Filter policyholders with unique locations and having duplicate tiv_2015
UniqueLocations AS (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
),

ValidPolicies AS (
    SELECT i.pid, i.tiv_2016
    FROM Insurance i
    JOIN DuplicateTiv2015 d ON i.tiv_2015 = d.tiv_2015
    JOIN UniqueLocations u ON i.lat = u.lat AND i.lon = u.lon
)

-- Step 3: Calculate the sum of tiv_2016 and round to 2 decimal places
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM ValidPolicies;
