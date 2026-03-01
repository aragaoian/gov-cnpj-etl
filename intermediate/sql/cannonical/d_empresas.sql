CREATE TABLE d_empresas (
    cnpj_basico CHAR(8) PRIMARY KEY,
    razao_social TEXT NOT NULL,
    natureza_juridica INTEGER NOT NULL,
    qualificacao_responsavel INTEGER,
    capital_social NUMERIC(18,2),
    porte_empresa SMALLINT,
    ente_federativo_responsavel TEXT
);