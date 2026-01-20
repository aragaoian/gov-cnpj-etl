CREATE TABLE staging.motivos (
    codigo TEXT,
    descricao TEXT
);

CREATE TABLE motivos (
    codigo INTEGER PRIMARY KEY,
    descricao TEXT NOT NULL
);