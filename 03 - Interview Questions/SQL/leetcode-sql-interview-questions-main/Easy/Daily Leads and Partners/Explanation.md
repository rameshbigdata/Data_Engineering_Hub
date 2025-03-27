To solve this problem, we can use the following steps in SQL:

1. **Group the data by `date_id` and `make_name`**: We need to group the data by these two columns because we want to calculate the number of distinct `lead_id` and distinct `partner_id` for each combination of `date_id` and `make_name`.
  
2. **Count distinct `lead_id` and `partner_id`**: For each group (defined by `date_id` and `make_name`), we will count the distinct `lead_id` and the distinct `partner_id`.

The SQL query that accomplishes this is as follows:

```sql
SELECT
    date_id,
    make_name,
    COUNT(DISTINCT lead_id) AS unique_leads,
    COUNT(DISTINCT partner_id) AS unique_partners
FROM
    DailySales
GROUP BY
    date_id,
    make_name;
```

### Explanation:
- **`COUNT(DISTINCT lead_id)`**: This counts the number of distinct `lead_id` values for each `date_id` and `make_name` combination.
- **`COUNT(DISTINCT partner_id)`**: This counts the number of distinct `partner_id` values for each `date_id` and `make_name` combination.
- **`GROUP BY date_id, make_name`**: This ensures that the counts are calculated for each unique combination of `date_id` and `make_name`.

This query will return the desired result with the number of unique leads and partners for each date and make.