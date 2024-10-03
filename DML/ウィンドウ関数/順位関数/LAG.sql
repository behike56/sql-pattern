WITH ranked_issues AS (
    SELECT
        ih.employee_id,
        ih.issue_date,
        ih.issue_type,
        ih.start_date,
        ih.retired_type,
        LAG(ih.issue_date) OVER (
            PARTITION BY ih.employee_id ORDER BY ih.issue_date DESC
        ) AS prev_issue_date
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
WHERE prev_issue_date IS NULL;  -- 直前の行がない（最新の行）
