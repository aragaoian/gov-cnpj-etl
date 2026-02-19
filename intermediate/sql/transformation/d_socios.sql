INSERT INTO d_socios (
    cnpj_basico,
    identificador_socio,
    nome_socio,
    cpf_cnpj_socio,
    qualificacao_socio,
    data_entrada_sociedade,
    pais,
    representante_legal,
    nome_representante,
    qualificacao_representante,
    faixa_etaria,
    ultima_versao_valida
)
SELECT DISTINCT
    cnpj_basico::CHAR(8),
    identificador_socio::SMALLINT,
    nome_socio::TEXT,
    NULLIF(cpf_cnpj_socio, '')::TEXT,
    NULLIF(qualificacao_socio, '')::INTEGER,
    parse_yyyymmdd_safe(data_entrada_sociedade),
    NULLIF(pais, '')::INTEGER,
    NULLIF(representante_legal, '')::TEXT,
    NULLIF(nome_representante, '')::TEXT,
    NULLIF(qualificacao_representante, '')::INTEGER,
    NULLIF(faixa_etaria, '')::SMALLINT,
    NOW()
FROM staging.socios