# 明細データ_WINDOW_exp

``` sql
mydatabase=# explain
mydatabase-# SELECT
    *
FROM (
    SELECT customer_id, seq, price,
            FIRST_VALUE(seq)
            OVER (PARTITION BY customer_id
                    ORDER BY seq) AS min_seq
    FROM receipts) TMP
WHERE seq = min_seq;
                                          QUERY PLAN
-----------------------------------------------------------------------------------------------
 Subquery Scan on tmp  (cost=0.15..113.40 rows=7 width=32)
   Filter: (tmp.seq = tmp.min_seq)
   ->  WindowAgg  (cost=0.15..95.28 rows=1450 width=32)
         ->  Index Scan using receipts_pkey on receipts  (cost=0.15..69.90 rows=1450 width=28)
(4 rows)
```
