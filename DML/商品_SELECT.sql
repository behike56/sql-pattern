SELECT item_name, year, price_tax_ex AS price
FROM items
WHERE year <= 2001
UNION ALL
SELECT item_name, year, price_tax_ex AS price
FROM items
WHERE year <= 2002;