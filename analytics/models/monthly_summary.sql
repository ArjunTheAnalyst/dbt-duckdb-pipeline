WITH totals AS
(SELECT
    month,
    SUM(postings) AS total_postings
FROM
    {{ ref('jobs_per_month') }}
GROUP BY
    month),

remote AS
(SELECT
    DATE_TRUNC('month', search_date) AS month,
    COUNT(*) AS remote_postings
FROM
    {{ ref('job_postings') }}
WHERE
    job_work_from_home = true
GROUP BY
    DATE_TRUNC('month', search_date))

SELECT
    totals.month,
    total_postings,
    remote_postings,
    ROUND(
    (100 * remote_postings) / total_postings, 1) AS remote_percentage
FROM
    totals
INNER JOIN
    remote
ON
    totals.month = remote.month
ORDER BY
    totals.month;