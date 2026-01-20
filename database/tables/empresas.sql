CREATE TABLE staging.empresas (
    cnpj_basico TEXT,
    razao_social TEXT,
    natureza_juridica TEXT,
    qualificacao_responsavel TEXT,
    capital_social TEXT,
    porte_empresa TEXT,
    ente_federativo_responsavel TEXT
);

CREATE TABLE empresas (
    cnpj_basico CHAR(8) PRIMARY KEY,
    razao_social TEXT NOT NULL,
    natureza_juridica INTEGER NOT NULL,
    qualificacao_responsavel INTEGER,
    capital_social NUMERIC(18,2),
    porte_empresa SMALLINT,
    ente_federativo_responsavel TEXT
);

