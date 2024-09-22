SELECT 
    R1.customer_id,
    R1.seq,
    R1.price

FROM
    receipts R1
    INNER JOIN
        (SELECT customer_id, MIN(seq) AS min_seq
        FROM receipts
        GROUP BY customer_id) R2
    ON R1.customer_id = R2.customer_id
    AND R1.seq = R2.min_seq;