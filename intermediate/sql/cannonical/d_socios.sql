CREATE TABLE d_socios (
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