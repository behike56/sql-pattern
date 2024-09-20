# exp_在職者

## サブクエリ

``` sql
mydatabase=# explain
SELECT emp.employee_id,
  tenure.issue_type,
  tenure.issue_date
FROM employee emp
  JOIN (
    SELECT ih1.employee_id,
      ih1.issue_type,
      ih1.issue_date
    FROM issue_history ih1
    WHERE ih1.issue_date = (
        SELECT MAX(ih2.issue_date)
        FROM issue_history ih2
          JOIN system_date sysd ON ih2.issue_date <= sysd.sys_date
          AND ih1.employee_id = ih2.employee_id
      )
      AND ih1.issue_type != '06'
  ) tenure ON emp.employee_id = tenure.employee_id;
                                                      QUERY PLAN
-----------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=0.00..732557.00 rows=9 width=10)
   Join Filter: (emp.employee_id = ih1.employee_id)
   ->  Seq Scan on employee emp  (cost=0.00..31.40 rows=2140 width=2)
   ->  Materialize  (cost=0.00..732236.72 rows=9 width=10)
         ->  Seq Scan on issue_history ih1  (cost=0.00..732236.68 rows=9 width=10)
               Filter: ((issue_type <> '06'::issue_type_enum) AND (issue_date = (SubPlan 1)))
               SubPlan 1
                 ->  Aggregate  (cost=413.66..413.67 rows=1 width=4)
                       ->  Nested Loop  (cost=4.22..394.54 rows=7650 width=4)
                             Join Filter: (ih2.issue_date <= sysd.sys_date)
                             ->  Seq Scan on system_date sysd  (cost=0.00..35.50 rows=2550 width=4)
                             ->  Materialize  (cost=4.22..14.81 rows=9 width=4)
                                   ->  Bitmap Heap Scan on issue_history ih2  (cost=4.22..14.76 rows=9 width=4)
                                         Recheck Cond: (ih1.employee_id = employee_id)
                                         ->  Bitmap Index Scan on issue_history_pkey  (cost=0.00..4.22 rows=9 width=0)
                                               Index Cond: (employee_id = ih1.employee_id)
 JIT:
   Functions: 23
   Options: Inlining true, Optimization true, Expressions true, Deforming true
(19 rows)
```

## WINDOW関数

``` sql
mydatabase=# explain
mydatabase-# SELECT emp.employee_id,
  tenure.issue_type,
  tenure.issue_date
FROM employee emp
  JOIN (
    SELECT ih1.employee_id,
      ih1.issue_type,
      ih1.issue_date,
      ROW_NUMBER() OVER (PARTITION BY ih1.employee_id ORDER BY ih1.issue_date DESC) as rn
    FROM issue_history ih1
    JOIN system_date sysd ON ih1.issue_date <= sysd.sys_date
    WHERE ih1.issue_type != '06'
  ) tenure ON emp.employee_id = tenure.employee_id
WHERE tenure.rn = 1; -- 最新のレコードを取得
                                                          QUERY PLAN
-------------------------------------------------------------------------------------------------------------------------------
 Merge Join  (cost=1092.94..284196.03 rows=7484 width=10)
   Merge Cond: (tenure.employee_id = emp.employee_id)
   ->  Subquery Scan on tenure  (cost=1092.78..284016.88 rows=7484 width=10)
         Filter: (tenure.rn = 1)
         ->  WindowAgg  (cost=1092.78..265306.25 rows=1496850 width=18)
               Run Condition: (row_number() OVER (?) <= 1)
               ->  Incremental Sort  (cost=1092.78..239111.38 rows=1496850 width=10)
                     Sort Key: ih1.employee_id, ih1.issue_date DESC
                     Presorted Key: ih1.employee_id
                     ->  Nested Loop  (cost=0.15..67479.25 rows=1496850 width=10)
                           Join Filter: (ih1.issue_date <= sysd.sys_date)
                           ->  Index Scan using issue_history_pkey on issue_history ih1  (cost=0.15..79.13 rows=1761 width=10)
                                 Filter: (issue_type <> '06'::issue_type_enum)
                           ->  Materialize  (cost=0.00..48.25 rows=2550 width=4)
                                 ->  Seq Scan on system_date sysd  (cost=0.00..35.50 rows=2550 width=4)
   ->  Index Only Scan using employee_pkey on employee emp  (cost=0.15..80.26 rows=2140 width=2)
 JIT:
   Functions: 16
   Options: Inlining false, Optimization false, Expressions true, Deforming true
(19 rows)
```
