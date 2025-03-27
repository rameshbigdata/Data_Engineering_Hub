SELECT em1.name
FROM Employee em1
JOIN Employee em2
ON em1.id = em2.managerId
GROUP BY em1.id, em1.name
HAVING COUNT(em1.id) >= 5;
