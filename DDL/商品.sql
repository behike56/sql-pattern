DROP TABLE IF EXISTS items;

CREATE TABLE items (
    item_id SMALLINT NOT NULL,
    year SMALLINT NOT NULL,
    item_name VARCHAR NOT NULL,
    price_tax_ex INTEGER NOT NULL,
    price_tax_in INTEGER NOT NULL,
    PRIMARY KEY (item_id, year)
);