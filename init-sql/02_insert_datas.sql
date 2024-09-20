-- 異動履歴情報テーブル
INSERT INTO issue_history 
-- 社員ID, 発令日付, 発令区分, 勤務開始日, 退職理由
(employee_id, issue_date, issue_type, start_date, retired_type) VALUES
-- 在職
(1, '2023-01-15', '01', '2023-01-01', NULL),
-- 在職、休職
(2, '2023-01-15', '01', '2023-01-01', NULL),
(2, '2023-02-01', '10', '2023-01-01', NULL),
-- 在職、休職、休職復帰
(3, '2022-12-10', '01', '2022-12-01', NULL),
(3, '2023-05-10', '10', '2022-12-01', NULL),
(3, '2024-02-10', '14', '2022-12-01', NULL),

-- 通常退職、システム日付・未満
(4, '2023-01-15', '01', '2023-01-01', NULL),
(4, '2024-09-05', '06', '2021-11-01', '020'),
-- 通常退職、システム日付・同日
(5, '2023-01-15', '01', '2023-01-01', NULL),
(5, '2024-10-01', '06', '2021-11-01', '020'),
-- 通常退職、システム日付・超過
(6, '2023-01-15', '01', '2023-01-01', NULL),
(6, '2024-10-10', '06', '2021-11-01', '020'),

-- 身分変更退職、システム日付・未満
(7, '2023-01-15', '01', '2023-01-01', NULL),
(7, '2024-08-05', '06', '2021-11-01', '030'),
-- 身分変更退職、システム日付・同日
(8, '2023-01-15', '01', '2023-01-01', NULL),
(8, '2024-10-01', '06', '2021-11-01', '030'),
-- 身分変更退退職、システム日付・超過
(9, '2023-01-15', '01', '2023-01-01', NULL),
(9, '2024-10-10', '06', '2021-11-01', '030'),

-- 休職、休職復帰、通常退職、システム日付・未満
(10, '2023-01-15', '01', '2023-01-01', NULL),
(10, '2023-05-10', '10', '2022-12-01', NULL),
(10, '2024-02-10', '14', '2022-12-01', NULL),
(10, '2024-05-05', '06', '2021-11-01', '010'),

-- 休職、休職復帰、通常退職、システム日付・同日
(11, '2023-01-15', '01', '2023-01-01', NULL),
(11, '2023-05-10', '10', '2022-12-01', NULL),
(11, '2024-02-10', '14', '2022-12-01', NULL),
(11, '2024-05-05', '06', '2021-11-01', '020'),

-- 休職、休職復帰、身分変更退職、システム日付・未満
(12, '2023-01-15', '01', '2023-01-01', NULL),
(12, '2023-05-10', '10', '2022-12-01', NULL),
(12, '2024-02-10', '14', '2022-12-01', NULL),
(12, '2024-05-05', '06', '2021-11-01', '030'),

-- 休職、休職復帰、身分変更退職、システム日付・同日
(13, '2023-01-15', '01', '2023-01-01', NULL),
(13, '2023-05-10', '10', '2022-12-01', NULL),
(13, '2024-02-10', '14', '2022-12-01', NULL),
(13, '2024-10-01', '06', '2021-11-01', '030'),

-- 休職、通常退職、システム日付・同日
(14, '2023-01-15', '01', '2023-01-01', NULL),
(14, '2023-05-10', '10', '2022-12-01', NULL),
(14, '2024-10-01', '06', '2021-11-01', '010');

-- 社員情報テーブル
INSERT INTO employee 
-- 社員ID, レコード有効日付, 入社日
(employee_id, record_enabled, entry_date) VALUES
(1, '2023-01-15', '2022-06-01'),
(2, '2022-12-10', '2020-05-15'),
(3, '2021-11-05', '2019-09-20'),
(4, '2021-11-05', '2019-09-20'),
(5, '2021-11-05', '2019-09-20'),
(6, '2021-11-05', '2019-09-20'),
(7, '2021-11-05', '2019-09-20'),
(8, '2021-11-05', '2019-09-20'),
(9, '2021-11-05', '2019-09-20'),
(10, '2021-11-05', '2019-09-20'),
(11, '2021-11-05', '2019-09-20'),
(12, '2021-11-05', '2019-09-20'),
(13, '2021-11-05', '2019-09-20'),
(14, '2021-11-05', '2019-09-20')
;

-- システム日付
INSERT INTO system_date (sys_date) VALUES ('2024-10-01');

INSERT INTO receipts (customer_id, seq, price)
VALUES
    ('C001', 1, 1500),
    ('C001', 2, 2300),
    ('C001', 3, 1200),
    ('C001', 4, 800),
    ('C001', 5, 2100),
    ('C002', 1, 1700),
    ('C002', 2, 3200),
    ('C002', 3, 1400),
    ('C002', 4, 900),
    ('C002', 5, 500),
    ('C003', 1, 2700),
    ('C003', 2, 1600),
    ('C003', 3, 2200),
    ('C003', 4, 1800),
    ('C003', 5, 1300),
    ('C004', 1, 1200),
    ('C004', 2, 1900),
    ('C004', 3, 2000),
    ('C004', 4, 700),
    ('C004', 5, 1100),
    ('C005', 1, 3000),
    ('C005', 2, 2700),
    ('C005', 3, 3500),
    ('C005', 4, 1500),
    ('C005', 5, 400),
    ('C006', 1, 1800),
    ('C006', 2, 900),
    ('C006', 3, 1300),
    ('C006', 4, 2500),
    ('C006', 5, 2100),
    ('C007', 1, 1000),
    ('C007', 2, 1500),
    ('C007', 3, 2400),
    ('C007', 4, 800),
    ('C007', 5, 2700),
    ('C008', 1, 1600),
    ('C008', 2, 3000),
    ('C008', 3, 1900),
    ('C008', 4, 2200),
    ('C008', 5, 1700),
    ('C009', 1, 1200),
    ('C009', 2, 900),
    ('C009', 3, 2700),
    ('C009', 4, 3500),
    ('C009', 5, 2100),
    ('C010', 1, 1500),
    ('C010', 2, 1800),
    ('C010', 3, 2400),
    ('C010', 4, 1000),
    ('C010', 5, 900);


INSERT INTO addresses (name, family_id, address)
VALUES
    ('Alice Smith', 1, '123 Main St, Springfield, IL'),
    ('Bob Smith', 1, '123 Main St, Springfield, IL'),
    ('Charlie Brown', 2, '456 Oak St, Springfield, IL'),
    ('David Brown', 2, '456 Oak St, Springfield, IL'),
    ('Eve Johnson', 3, '789 Pine St, Springfield, IL'),
    ('Frank Johnson', 3, '789 Pine St, Springfield, IL'),
    ('Grace Lee', 4, '101 Maple St, Springfield, IL'),
    ('Hank Lee', 4, '101 Maple St, Springfield, IL'),
    ('Ivy White', 5, '202 Cedar St, Springfield, IL'),
    ('Jack White', 5, '202 Cedar St, Springfield, IL'),
    ('Kathy Green', 6, '303 Birch St, Springfield, IL'),
    ('Leo Green', 6, '303 Birch St, Springfield, IL'),
    ('Mona Black', 7, '404 Walnut St, Springfield, IL'),
    ('Nina Black', 7, '404 Walnut St, Springfield, IL'),
    ('Oscar Blue', 8, '505 Elm St, Springfield, IL'),
    ('Paul Blue', 8, '505 Elm St, Springfield, IL'),
    ('Quinn Gray', 9, '606 Ash St, Springfield, IL'),
    ('Ray Gray', 9, '606 Ash St, Springfield, IL'),
    ('Sara Red', 10, '707 Willow St, Springfield, IL'),
    ('Tom Red', 10, '707 Willow St, Springfield, IL'),
    ('Uma Silver', 11, '808 Spruce St, Springfield, IL'),
    ('Victor Silver', 11, '808 Spruce St, Springfield, IL'),
    ('Wendy Gold', 12, '909 Sycamore St, Springfield, IL'),
    ('Xander Gold', 12, '909 Sycamore St, Springfield, IL'),
    ('Yara Pink', 13, '1010 Hawthorn St, Springfield, IL'),
    ('Zane Pink', 13, '1010 Hawthorn St, Springfield, IL'),
    ('Amy Orange', 14, '1111 Redwood St, Springfield, IL'),
    ('Blake Orange', 14, '1111 Redwood St, Springfield, IL'),
    ('Clara Purple', 15, '1212 Dogwood St, Springfield, IL'),
    ('Dylan Purple', 15, '1212 Dogwood St, Springfield, IL'),
    ('Emma Cyan', 16, '1313 Magnolia St, Springfield, IL'),
    ('Felix Cyan', 16, '1313 Magnolia St, Springfield, IL'),
    ('Georgia Brown', 17, '1414 Olive St, Springfield, IL'),
    ('Henry Brown', 17, '1414 Olive St, Springfield, IL'),
    ('Isla Red', 18, '1515 Poplar St, Springfield, IL'),
    ('Jake Red', 18, '1515 Poplar St, Springfield, IL'),
    ('Kelly Green', 19, '1616 Fir St, Springfield, IL'),
    ('Liam Green', 19, '1616 Fir St, Springfield, IL'),
    ('Mia Blue', 20, '1717 Cypress St, Springfield, IL'),
    ('Noah Blue', 20, '1717 Cypress St, Springfield, IL'),
    ('Olivia Silver', 21, '1818 Beech St, Springfield, IL'),
    ('Peter Silver', 21, '1818 Beech St, Springfield, IL'),
    ('Queen Orange', 22, '1919 Palm St, Springfield, IL'),
    ('Riley Orange', 22, '1919 Palm St, Springfield, IL'),
    ('Sophie Gold', 23, '2020 Juniper St, Springfield, IL'),
    ('Tyler Gold', 23, '2020 Juniper St, Springfield, IL'),
    ('Una Pink', 24, '2121 Chestnut St, Springfield, IL'),
    ('Vince Pink', 24, '2121 Chestnut St, Springfield, IL'),
    ('Alice Pink', 24, '2129 Chestnut St, Springfield, IL'),
    ('Bob SmitGoldh', 23, '2015 Juniper St, Springfield, IL'),
    ('Charlie Orange', 22, '1920 Palm St, Springfield, IL'),
    ('David Silver', 21, '1835 Beech St, Springfield, IL');
