-- SQL Toolsのセッション用sql
SELECT ih.employee_id,
    ih.issue_date,
    ih.issue_type,
    ih.start_date,
    ih.retired_type
FROM
    system_date sd,
    issue_history ih

WHERE
    ih.issue_date >= sd.sys_date
    AND ih.issue_type = '06';

SELECT * FROM system_date;


SELECT 
    ih.employee_id,
    ih.issue_date,
    ih.issue_type,
    ih.start_date,
    ih.retired_type,
    sd.sys_date

FROM 
    system_date sd,
    issue_history ih
    JOIN (
        SELECT 
            employee_id
        FROM 
            issue_history
        WHERE
            issue_date >= sd.sys_date
            AND ih.issue_type = '06'
    ) retired
    ON ih.employee_id = retired.employee_id
    JOIN (
        SELECT
            employee_id
        FROM 
            issue_history
        WHERE
            issue_date >= sd.sys_date
            AND ih.issue_type != '06'
    ) worker
    ON ih.employee_id = worker.employee_id;
    

SELECT 
    ih.employee_id,
    ih.issue_date,
    ih.issue_type,
    ih.start_date,
    ih.retired_type,
    sd.sys_date
FROM 
    issue_history ih
JOIN system_date sd 
    ON ih.issue_date >= sd.sys_date
JOIN (
    SELECT 
        employee_id
    FROM 
        issue_history
    WHERE
        issue_date >= (SELECT MAX(sys_date) FROM system_date)
        AND issue_type = '06'
) retired
    ON ih.employee_id = retired.employee_id
JOIN (
    SELECT
        employee_id
    FROM 
        issue_history
    WHERE
        issue_date >= (SELECT MAX(sys_date) FROM system_date)
        AND issue_type != '06'
) worker
    ON ih.employee_id = worker.employee_id;


SELECT t1.*
FROM your_table t1
INNER JOIN (
    SELECT id, MAX(created_at) AS max_created_at
    FROM your_table
    WHERE created_at <= 'YYYY-MM-DD'
    GROUP BY id
) t2
ON t1.id = t2.id AND t1.created_at = t2.max_created_at;

WITH latest_issue AS (
    SELECT ih1.employee_id, ih1.issue_date, ih1.issue_type, ih1.retired_type
    FROM issue_history ih1
    JOIN system_date sd
      ON ih1.issue_date <= sd.sys_date
    WHERE (ih1.employee_id, ih1.issue_date) IN (
        SELECT ih2.employee_id, MAX(ih2.issue_date)
        FROM issue_history ih2
        WHERE ih2.issue_date <= sd.sys_date
        GROUP BY ih2.employee_id
    )
),
retirement_records AS (
    SELECT ih.employee_id, ih.issue_date
    FROM issue_history ih
    WHERE ih.issue_type = '06'
      AND ih.retired_type != '030'
      AND EXISTS (
          SELECT 1
          FROM system_date sd
          WHERE sd.sys_date BETWEEN ih.issue_date AND ih.issue_date + INTERVAL '1 month'
      )
),
suspension_records AS (
    SELECT ih.employee_id, ih.issue_date AS rest_start, '9999-12-31'::DATE AS rest_end
    FROM issue_history ih
    WHERE ih.issue_type = '10'
),
return_to_work_records AS (
    SELECT ih.employee_id, sr.rest_start, ih.issue_date AS rest_end
    FROM issue_history ih
    JOIN suspension_records sr
      ON ih.employee_id = sr.employee_id
    WHERE ih.issue_type = '14'
)
SELECT l.employee_id, l.issue_date, l.issue_type, l.retired_type, 
       sr.rest_start, rtw.rest_end
FROM latest_issue l
LEFT JOIN retirement_records rr
  ON l.employee_id = rr.employee_id
LEFT JOIN suspension_records sr
  ON l.employee_id = sr.employee_id
LEFT JOIN return_to_work_records rtw
  ON l.employee_id = rtw.employee_id;

SELECT emp.employee_id,
  tenure.issue_type,
  tenure.issue_date
FROM employee emp
  JOIN (
    SELECT ih1.employee_id,
      ih1.issue_type,
      ih1.issue_date,
      ROW_NUMBER() OVER (PARTITION BY ih1.employee_id ORDER BY ih1.issue_date DESC) as rn
    FROM issue_history ih1
    JOIN system_date sysd ON ih1.issue_date <= sysd.sys_date
    WHERE ih1.issue_type != '06'
  ) tenure ON emp.employee_id = tenure.employee_id
WHERE tenure.rn = 1;
