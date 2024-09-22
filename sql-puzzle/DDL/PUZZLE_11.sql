DROP TABLE IF EXISTS Projects;

-- 工程は順番に進み、工程ステータスは完了か前工程を待つ、待機のどちらかの状態を持つ。
-- 工程が3つある場合、1:C,2:W,3:Cという状態はありえないということ。
CREATE TABLE Projects(
    workorder_id CHAR(5) NOT NUll,
    step_nbr INTEGER NOT NULL
        CHECK (step_nbr BETWEEN 0 AND 1000),
    step_status CHAR(1) NOT NULL
        CHECK (step_status IN ('C', 'W')), -- Cは完了、Wは待機
    PRIMARY KEY (workorder_id, step_nbr)
);

COMMENT ON TABLE Projects IS 'プロジェクトテーブル';
COMMENT ON COLUMN Projects.workorder_id IS '作業依頼ID';
COMMENT ON COLUMN Projects.step_nbr IS '工程番号';
COMMENT ON COLUMN Projects.step_status IS '工程ステータス';