SELECT
    f.employee_id,
    f.enabled_date,
    f.seq,
    CASE
        WHEN fc.age6_count = 1 THEN 5
        WHEN fc.age6_count >= 2 THEN 10
    END AS check
FROM
    family f
    JOIN (
        SELECT ih.employee_id,
            ih.issue_date,
            ih.issue_type,
            ih.start_date,
            ih.retired_type
        FROM issue_history ih
            JOIN (
                -- システム日付以前の日付で最大の日付を持つレコード
                SELECT ih2.employee_id,
                    MAX(ih2.issue_date) AS issue_date
                FROM issue_history ih2
                    JOIN system_date sdate ON ih2.issue_date <= sdate.sys_date
                GROUP BY ih2.employee_id
            ) tenure ON ih.employee_id = tenure.employee_id
            AND ih.issue_date = tenure.issue_date
        WHERE ih.issue_type != '06'
    ) tenure ON f.employee_id = tenure.employee_id
    INNER JOIN (
        -- 6歳以上の家族の人数を集計
        SELECT
            employee_id,
            COUNT(*) AS age6_count
        FROM family
        WHERE EXTRACT(YEAR FROM AGE('2024-11-10', birth_day)) >= 6
        GROUP BY employee_id
    ) fc ON f.employee_id = fc.employee_id;
