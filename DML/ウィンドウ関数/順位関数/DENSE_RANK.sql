WITH ranked_issues AS (
    SELECT
        ih.employee_id,
        ih.issue_date,
        ih.issue_type,
        ih.start_date,
        ih.retired_type,
        DENSE_RANK() OVER (
            PARTITION BY ih.employee_id ORDER BY ih.issue_date DESC
        ) AS rnk
    FROM
        issue_history ih
    CROSS JOIN
        system_date sd
    WHERE
        ih.issue_date <= sd.sys_date
        AND ih.issue_type <> '06'
)
SELECT
    employee_id,
    issue_date,
    issue_type,
    start_date,
    retired_type
FROM
    ranked_issues
WHERE rnk = 1;
