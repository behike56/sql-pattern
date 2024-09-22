DROP TABLE IF EXISTS FiscalYearTable1;
-- start_date, end_dateに対する制約を付加。CHECKのほかUNIQUEでも良い。
-- 全てNOT NULL。
-- CHECK ((end_date - start_date) = INTERVAL '359' DAY)
CREATE TABLE FiscalYearTable1 (
    fiscal_year INTEGER NOT NULL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CONSTRAINT valid_start_date
    CHECK (
        (EXTRACT(YEAR FROM start_date) = fiscal_year - 1)
        AND (EXTRACT(MONTH FROM start_date) = 10)
        AND (EXTRACT(DAY FROM start_date) = 1)
    ),
    CONSTRAINT valid_end_date
    CHECK (
        (EXTRACT(YEAR FROM end_date) = fiscal_year)
        AND (EXTRACT(MONTH FROM end_date) = 9)
        AND (EXTRACT(DAY FROM end_date) = 30)
    )
);
