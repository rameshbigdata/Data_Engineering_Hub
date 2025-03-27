-- Count the number of friends for each person
WITH FriendCounts AS (
    SELECT 
        requester_id AS person_id, 
        COUNT(accepter_id) AS friend_count
    FROM RequestAccepted
    GROUP BY requester_id
    
    UNION ALL
    
    SELECT 
        accepter_id AS person_id, 
        COUNT(requester_id) AS friend_count
    FROM RequestAccepted
    GROUP BY accepter_id
),

-- Aggregate friend counts for each person
AggregatedCounts AS (
    SELECT 
        person_id, 
        SUM(friend_count) AS total_friends
    FROM FriendCounts
    GROUP BY person_id
)

-- Find the person with the maximum number of friends
SELECT 
    person_id AS id, 
    total_friends AS num
FROM AggregatedCounts
ORDER BY total_friends DESC
LIMIT 1;
