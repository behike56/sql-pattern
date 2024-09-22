-- 自己結合
SELECT
    DISTINCT A1.name, A1.family_id, A1.address
FROM addresses A1 INNER JOIN addresses A2
    ON A1.family_id = A2.family_id
    AND A1.address <> A2.address;

-- HAVING句
SELECT family_id
FROM addresses
GROUP BY family_id
HAVING MIN(address) <> MAX(address);

-- WINDOW関数
SELECT *
FROM (SELECT name, address,
        MAX(address) OVER(PARTITION BY family_id) max_address,
        MIN(address) OVER(PARTITION BY family_id) min_address
    FROM addresses) MAX_MIN
WHERE max_address <> min_address;