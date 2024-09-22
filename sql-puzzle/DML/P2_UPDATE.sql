-- 前日に欠勤していないかを調べ、もし欠勤していれば第二のルールに従い、
-- 挿入された行の罰点を0点にし、理由を「長期病欠」に変更する。
UPDATE Absenteeism
SET severity_points = 0,
    reason_code = 'long term illness'
WHERE EXISTS
    (SELECT *
    FROM Absenteeism AS A2
    WHERE Absenteeism.emp_id = A2.emp_id
    AND Absenteeism.absent_date = (A2.absent_date + INTERVAL '1' DAY));