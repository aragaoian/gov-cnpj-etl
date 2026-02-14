CREATE TABLE staging.socios (
    cnpj_basico TEXT,
    identificador_socio TEXT,
    nome_socio TEXT,
    cpf_cnpj_socio TEXT,
    qualificacao_socio TEXT,
    data_entrada_sociedade TEXT,
    pais TEXT,
    representante_legal TEXT,
    nome_representante TEXT,
    qualificacao_representante TEXT,
    faixa_etaria TEXT
);

CREATE TABLE socios (
    cnpj_basico CHAR(8),
    identificador_socio SMALLINT,
    nome_socio TEXT NOT NULL,
    cpf_cnpj_socio TEXT,
    qualificacao_socio INTEGER,
    data_entrada_sociedade DATE,
    pais INTEGER,
    representante_legal TEXT,
    nome_representante TEXT,
    qualificacao_representante INTEGER,
    faixa_etaria SMALLINT,
    ultima_versao_valida DATE
);


