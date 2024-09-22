-- 最初のseqを抽出
SELECT
    *
FROM (
    SELECT customer_id, seq, price,
            FIRST_VALUE(seq)
            OVER (PARTITION BY customer_id
                    ORDER BY seq) AS min_seq
    FROM receipts) TMP
WHERE seq = min_seq;

-- 最後のseqを抽出
SELECT
    *
FROM (
    SELECT customer_id, seq, price,
            LAST_VALUE(seq)
            OVER (PARTITION BY customer_id
                    ORDER BY seq
                    RANGE BETWEEN CURRENT ROW
                    AND UNBOUNDED FOLLOWING) AS max_seq
    FROM receipts) TMP
WHERE seq = max_seq;

-- ３番目のseqを抽出
SELECT
    *
FROM (
    SELECT customer_id, seq, price,
            NTH_VALUE(seq, 3) OVER (PARTITION BY customer_id
                                    ORDER BY seq) AS seq_3rd
    FROM receipts) TMP
WHERE seq = seq_3rd;