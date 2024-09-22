-- Personnelテーブルへのデータ挿入
INSERT INTO Personnel (emp_id)
VALUES (1),
    (2),
    (3);
-- ExcuseListテーブルへのデータ挿入
INSERT INTO ExcuseList (reason_code)
VALUES ('Sick Leave'),
    ('Vacation'),
    ('Personal Leave'),
    ('long term illness');

-- Absenteeismテーブルへのデータ挿入
INSERT INTO Absenteeism (emp_id, absent_date, reason_code, severity_points) VALUES
(1, '2023-01-10', 'Sick Leave', 2),
(1, '2023-01-11', 'Sick Leave', 2),
(2, '2023-02-15', 'Vacation', 0),
(3, '2023-03-20', 'Personal Leave', 1);

-- Absenteeismテーブルへのデータ挿入
INSERT INTO Absenteeism (emp_id, absent_date, reason_code, severity_points) VALUES
(3, '2023-03-25', 'Personal Leave', 39);