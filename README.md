# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# 水質検査データ管理システム

## データベース設計
```mermaid
erDiagram
    plants ||--o{ samples : "has"
    samples ||--o{ results : "has"
    test_items ||--o{ results : "references"

    plants {
        bigint id PK
        string name "NOT NULL"
        string location
        text remarks
        datetime created_at
        datetime updated_at
    }

    samples {
        bigint id PK
        bigint plant_id FK "NOT NULL"
        date sampling_date "NOT NULL"
        time sampling_time "NOT NULL"
        string location
        string inspector
        text remarks
        datetime created_at
        datetime updated_at
    }

    test_items {
        bigint id PK
        string name "NOT NULL"
        string unit
        float detection_limit
        float standard_min
        float standard_max
        integer sort_order
        datetime created_at
        datetime updated_at
    }

    results {
        bigint id PK
        bigint sample_id FK "NOT NULL"
        bigint test_item_id FK "NOT NULL"
        string value
        datetime created_at
        datetime updated_at
    }

    users {
        bigint id PK
        string email "NOT NULL, UNIQUE"
        string encrypted_password "NOT NULL"
        boolean admin "DEFAULT false, NOT NULL"
        string reset_password_token
        datetime reset_password_sent_at
        datetime remember_created_at
        datetime created_at
        datetime updated_at
    }
```
