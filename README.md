# sql-pattern

SQLパターン。

## コンテナ作成

[PostgreSQLコンテナ作成](./docs/PostgreSQLコンテナ作成.md)

## DB接続

プラグインを利用

- SQLTools
  - PostgreSQL
  - SQLTools postgreSQL/Cockroach Driver

## SQL

`./sql`配下に配置。
`./TestDB.session.sql`はSQLToolsのセッション用。

## ファイルとディレクトリ構造

``` text
top
├── README.md
├── TestDB.session.sql
├── compose.yaml                ; コンテナ定義
├── docs
│   └── PostgreSQLコンテナ作成.md
├── init-sql                    ; コンテナ作成時のDDL
│   ├── 01_create_tables.sql
│   └── 02_insert_datas.sql
├── sql                         ; SQLを配置
└── template                    ; Docker Desktopが作成したテンプレート
    ├── Dockerfile-temp
    └── compose-temp.yaml

5 directories, 8 files
```
