SELECT user_id, name, mail
FROM Users
WHERE mail LIKE '%@leetcode.com'
  AND LENGTH(mail) > LENGTH('@leetcode.com')
  AND REGEXP_LIKE(SUBSTRING(mail, 1, LENGTH(mail) - LENGTH('@leetcode.com')), '^[A-Za-z][A-Za-z0-9_.-]*$');
