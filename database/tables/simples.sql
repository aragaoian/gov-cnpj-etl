CREATE TABLE staging.simples (
    cnpj_basico TEXT,
    opcao_simples TEXT,
    data_opcao_simples TEXT,
    data_exclusao_simples TEXT,
    opcao_mei TEXT,
    data_opcao_mei TEXT,
    data_exclusao_mei TEXT
);

CREATE TABLE simples (
    cnpj_basico CHAR(8) PRIMARY KEY,
    opcao_simples CHAR(1),
    data_opcao_simples DATE,
    data_exclusao_simples DATE,
    opcao_mei CHAR(1),
    data_opcao_mei DATE,
    data_exclusao_mei DATE
);

