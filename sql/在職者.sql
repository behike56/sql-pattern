-- システム日付時点で最新の状態が「退職」ではない従業員を抽出。
SELECT ih.employee_id,
    ih.issue_date,
    ih.issue_type,
    ih.start_date,
    ih.retired_type
FROM
    issue_history ih
    JOIN ( -- システム日付以前の日付で最大の日付を持つレコード
        SELECT ih2.employee_id, MAX(ih2.issue_date) as issue_date
        FROM issue_history ih2
        JOIN system_date sdate
        ON ih2.issue_date <= sdate.sys_date
        GROUP BY ih2.employee_id
    ) tenure
    ON ih.employee_id = tenure.employee_id
    AND ih.issue_date = tenure.issue_date
    AND ih.issue_type != '06'
;