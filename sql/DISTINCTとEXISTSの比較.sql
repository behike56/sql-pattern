SELECT DISTINCT ih.employee_id
FROM issue_history ih
JOIN employee emp
  ON ih.employee_id = emp.employee_id;

SELECT emp.employee_id
FROM employee emp
WHERE EXISTS (
    SELECT 1
    FROM issue_history ih
    WHERE ih.employee_id = emp.employee_id
);