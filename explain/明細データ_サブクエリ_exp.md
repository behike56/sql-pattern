# 明細データ_サブクエリ_exp

``` sql
mydatabase=# explain
mydatabase-# SELECT
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
                                        QUERY PLAN
-------------------------------------------------------------------------------------------
 Hash Join  (cost=38.75..70.86 rows=7 width=28)
   Hash Cond: ((r1.customer_id = receipts.customer_id) AND (r1.seq = (min(receipts.seq))))
   ->  Seq Scan on receipts r1  (cost=0.00..24.50 rows=1450 width=28)
   ->  Hash  (cost=35.75..35.75 rows=200 width=24)
         ->  HashAggregate  (cost=31.75..33.75 rows=200 width=24)
               Group Key: receipts.customer_id
               ->  Seq Scan on receipts  (cost=0.00..24.50 rows=1450 width=24)
(7 rows)
```
