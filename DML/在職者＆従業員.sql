SELECT emp.employee_id,
  tenure.issue_type,
  tenure.issue_date
FROM employee emp
  JOIN (
    SELECT ih1.employee_id,
      ih1.issue_type,
      ih1.issue_date
    FROM issue_history ih1
    WHERE ih1.issue_date = (
        SELECT MAX(ih2.issue_date)
        FROM issue_history ih2
          JOIN system_date sysd ON ih2.issue_date <= sysd.sys_date
          AND ih1.employee_id = ih2.employee_id
      )
      AND ih1.issue_type != '06'
  ) tenure ON emp.employee_id = tenure.employee_id;