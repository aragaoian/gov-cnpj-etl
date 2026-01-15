CREATE TABLE IF NOT EXISTS staging.cnaes (
    code INTEGER PRIMARY KEY,
    activity_name TEXT,
)

CREATE TABLE IF NOT EXISTS {SCHEMA}.cnaes (
    code INTEGER PRIMARY KEY,
    activity_name TEXT NOT NULL,
    related_year INTEGER NOT NULL
);