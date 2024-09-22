DROP TABLE IF EXISTS Personnel;
CREATE TABLE Personnel(
    emp_id INTEGER PRIMARY KEY
);

DROP TABLE IF EXISTS ExcuseList;
CREATE TABLE ExcuseList(
    reason_code VARCHAR(40) PRIMARY KEY
);

DROP TABLE IF EXISTS Absenteeism;
-- 従業員は罰点(severity_points)を年間40ポイント貯めると解雇される。
-- 2日以上連続で休んだ場合は「長期病欠’扱いとなり、２日目以降罰点がつかない。
CREATE TABLE Absenteeism (
    emp_id INTEGER NOT NULL REFERENCES Personnel (emp_id)
        ON DELETE CASCADE, -- Personnelの従業員が削除される時、同時に削除される。
    absent_date DATE NOT NULL,
    reason_code VARCHAR(40) NOT NULL REFERENCES ExcuseList (reason_code),
    severity_points INTEGER NOT NULL CHECK (severity_points BETWEEN 0 AND 4),
    PRIMARY KEY (emp_id, absent_date)
);

COMMENT ON TABLE Absenteeism IS '欠勤テーブル';
COMMENT ON COLUMN Absenteeism.emp_id IS '社員ID';
COMMENT ON COLUMN Absenteeism.absent_date IS '欠勤日';
COMMENT ON COLUMN Absenteeism.reason_code IS '理由コード';
COMMENT ON COLUMN Absenteeism.severity_points IS '罰点';


