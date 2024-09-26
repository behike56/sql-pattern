CREATE TABLE family (
    employee_id SMALLINT NOT NULL,
    enabled_date DATE NOT NULL,
    seq SMALLINT NOT NULL,
    birth_day DATE NOT NULL,
    PRIMARY KEY (employee_id, enabled_date, seq)
);