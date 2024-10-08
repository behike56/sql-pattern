-- 異動区分: 雇用、昇進、出向、出向復帰、退職、休職、休職復帰、
CREATE TYPE issue_type_enum AS ENUM ('01', '02', '03', '04', '06', '10', '14', '15');
-- 退職区分: 自己都合、希望退職、身分変更、定年退職、介護、死亡、懲戒免職
CREATE TYPE retired_type_enum AS ENUM ('010', '020', '030', '040', '050', '060');

-- 異動履歴
CREATE TABLE issue_history (
    employee_id SMALLINT NOT NULL,
    issue_date DATE NOT NULL,
    issue_type issue_type_enum NOT NULL,
    start_date DATE NOT NULL,
    retired_type retired_type_enum,
    PRIMARY KEY (employee_id, issue_date)
);

COMMENT ON TABLE issue_history IS '異動履歴';
COMMENT ON COLUMN issue_history.employee_id IS '従業員ID';
COMMENT ON COLUMN issue_history.issue_date IS '異動日付';
COMMENT ON COLUMN issue_history.issue_type IS '異動区分';
COMMENT ON COLUMN issue_history.start_date IS '勤務開始日';
COMMENT ON COLUMN issue_history.retired_type IS '退職理由';


-- 従業員
CREATE TABLE employee (
    employee_id SMALLINT NOT NULL,
    record_enabled DATE NOT NULL,
    entry_date DATE,
    PRIMARY KEY (employee_id)
);

COMMENT ON TABLE employee IS '従業員';
COMMENT ON COLUMN employee.employee_id IS '従業員ID';
COMMENT ON COLUMN employee.record_enabled IS 'レコード有効日付';
COMMENT ON COLUMN employee.entry_date IS '入社日';


-- システム日付
CREATE TABLE system_date (
    sys_date DATE NOT NULL
);

COMMENT ON TABLE system_date IS 'システム日付';
COMMENT ON COLUMN system_date.sys_date IS '日付';

CREATE TABLE receipts (
    customer_id CHAR(4) NOT NULL,
    seq INTEGER NOT NULL,
    price INTEGER NOT NULL,
    PRIMARY KEY (customer_id, seq)
);

COMMENT ON TABLE receipts IS '購入明細';
COMMENT ON COLUMN receipts.customer_id IS '顧客ID';
COMMENT ON COLUMN receipts.seq IS '枝番';
COMMENT ON COLUMN receipts.price IS '購入価格';


CREATE TABLE addresses (
    name VARCHAR(32) NOT NULL,
    family_id INTEGER NOT NULL,
    address VARCHAR(64) NOT NULL,
    CONSTRAINT pk_addresses PRIMARY KEY(name)
);

COMMENT ON TABLE addresses IS '住所';
COMMENT ON COLUMN addresses.name IS '従業員名';
COMMENT ON COLUMN addresses.family_id IS '家族ID';
COMMENT ON COLUMN addresses.address IS '住所';
