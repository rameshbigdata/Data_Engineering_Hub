WITH RankedEmails AS (
    SELECT
        id,
        email,
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
    FROM Person
)
DELETE FROM Person
WHERE id IN (
    SELECT id
    FROM RankedEmails
    WHERE rn > 1
);
