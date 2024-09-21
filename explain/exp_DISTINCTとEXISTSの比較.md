# exp_DISTINCTとEXISTSの比較

## DISTINCT

``` sql
mydatabase=# explain
mydatabase-# SELECT DISTINCT ih.employee_id
FROM issue_history ih
JOIN employee emp
  ON ih.employee_id = emp.employee_id;
                                    QUERY PLAN
----------------------------------------------------------------------------------
 HashAggregate  (cost=94.93..96.93 rows=200 width=2)
   Group Key: ih.employee_id
   ->  Hash Join  (cost=58.15..90.51 rows=1770 width=2)
         Hash Cond: (ih.employee_id = emp.employee_id)
         ->  Seq Scan on issue_history ih  (cost=0.00..27.70 rows=1770 width=2)
         ->  Hash  (cost=31.40..31.40 rows=2140 width=2)
               ->  Seq Scan on employee emp  (cost=0.00..31.40 rows=2140 width=2)
(7 rows)
```

## EXISTS

``` sql
mydatabase=# explain
mydatabase-# SELECT emp.employee_id
FROM employee emp
WHERE EXISTS (
    SELECT 1
    FROM issue_history ih
    WHERE ih.employee_id = emp.employee_id
);
                                      QUERY PLAN
--------------------------------------------------------------------------------------
 Hash Join  (cost=36.62..85.55 rows=1070 width=2)
   Hash Cond: (emp.employee_id = ih.employee_id)
   ->  Seq Scan on employee emp  (cost=0.00..31.40 rows=2140 width=2)
   ->  Hash  (cost=34.12..34.12 rows=200 width=2)
         ->  HashAggregate  (cost=32.12..34.12 rows=200 width=2)
               Group Key: ih.employee_id
               ->  Seq Scan on issue_history ih  (cost=0.00..27.70 rows=1770 width=2)
(7 rows)
```
