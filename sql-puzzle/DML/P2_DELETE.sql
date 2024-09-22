-- 40点以上の従業員のレコードを削除する
DELETE FROM Personnel
WHERE emp_id =
    (SELECT A1.emp_id
    FROM Absenteeism AS A1
    WHERE A1.emp_id = Personnel.emp_id
        AND absent_date
            BETWEEN CURRENT_TIMESTAMP - INTERVAL '365' DAY
            AND CURRENT_TIMESTAMP
    GROUP BY A1.emp_id
    HAVING SUM(severity_points) >= 40);