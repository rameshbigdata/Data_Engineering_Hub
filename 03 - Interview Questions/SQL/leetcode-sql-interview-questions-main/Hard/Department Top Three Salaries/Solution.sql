WITH RankedSalaries AS (
    SELECT
        e.id,
        e.name,
        e.salary,
        e.departmentId,
        d.name AS departmentName,
        DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS salaryRank
    FROM
        Employee e
    JOIN
        Department d ON e.departmentId = d.id
),
TopSalaries AS (
    SELECT
        departmentName,
        name AS Employee,
        salary
    FROM
        RankedSalaries
    WHERE
        salaryRank <= 3
)
SELECT
    departmentName AS Department,
    Employee,
    salary AS Salary
FROM
    TopSalaries
ORDER BY
    departmentName, Salary DESC;
