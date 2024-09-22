-- 0番を除く全工程のstep_statusが'W'である。
-- 'W'が0番を除く全工程のstep_statusである。
SELECT workorder_id
FROM projects AS p1
WHERE step_nbr = 0
    AND step_status = 'C'
    AND 'W' = ALL (SELECT step_status
                    FROM projects AS p2
                    WHERE step_nbr <> 0
                    AND p1.workorder_id = p2.workorder_id);

-- CASE式を使用した方法。
SELECT workorder_id
FROM projects AS p1
GROUP BY workorder_id
HAVING SUM(CASE WHEN step_nbr <> 0 AND step_status = 'W' THEN 1
                WHEN step_nbr = 0 AND step_status = 'C' THEN 1
                ELSE 0 END) = COUNT(step_nbr);

-- step_nbrは数値のため合計を求めるだけで状態がわかる。
SELECT workorder_id
FROM projects AS p1
WHERE step_status = 'C'
GROUP BY workorder_id
HAVING SUM(step_nbr)