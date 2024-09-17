# exp_住所

## 自己結合

``` sql
mydatabase=# explain SELECT
    DISTINCT A1.name, A1.family_id, A1.address
FROM addresses A1 INNER JOIN addresses A2
    ON A1.family_id = A2.family_id
    AND A1.address <> A2.address;
                                   QUERY PLAN
--------------------------------------------------------------------------------
 HashAggregate  (cost=6.30..6.82 rows=52 width=46)
   Group Key: a1.name, a1.family_id, a1.address
   ->  Hash Join  (cost=2.17..5.46 rows=112 width=46)
         Hash Cond: (a1.family_id = a2.family_id)
         Join Filter: ((a1.address)::text <> (a2.address)::text)
         ->  Seq Scan on addresses a1  (cost=0.00..1.52 rows=52 width=46)
         ->  Hash  (cost=1.52..1.52 rows=52 width=35)
               ->  Seq Scan on addresses a2  (cost=0.00..1.52 rows=52 width=35)
(8 rows)
```

## HAVING句

``` sql
mydatabase=# explain SELECT family_id
FROM addresses
GROUP BY family_id
HAVING MIN(address) <> MAX(address);
                           QUERY PLAN
-----------------------------------------------------------------
 HashAggregate  (cost=1.91..2.21 rows=24 width=4)
   Group Key: family_id
   Filter: (min((address)::text) <> max((address)::text))
   ->  Seq Scan on addresses  (cost=0.00..1.52 rows=52 width=35)
(4 rows)
```

## WINDOW関数

``` sql
mydatabase=# explain SELECT *
FROM (SELECT name, address,
        MAX(address) OVER(PARTITION BY family_id) max_address,
        MIN(address) OVER(PARTITION BY family_id) min_address
    FROM addresses) MAX_MIN
WHERE max_address <> min_address;
                                 QUERY PLAN
-----------------------------------------------------------------------------
 Subquery Scan on max_min  (cost=3.00..4.69 rows=52 width=106)
   Filter: (max_min.max_address <> max_min.min_address)
   ->  WindowAgg  (cost=3.00..4.04 rows=52 width=110)
         ->  Sort  (cost=3.00..3.13 rows=52 width=46)
               Sort Key: addresses.family_id
               ->  Seq Scan on addresses  (cost=0.00..1.52 rows=52 width=46)
(6 rows)
```
