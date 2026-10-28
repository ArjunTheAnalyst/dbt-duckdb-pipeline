SELECT
    DATE_TRUNC('month', search_date) AS month,
    search_term AS role,
    COUNT(*) AS postings
FROM
    {{ ref('job_postings')}}
GROUP BY
    DATE_TRUNC('month', search_date),
    search_term
ORDER BY
    month,
    role;