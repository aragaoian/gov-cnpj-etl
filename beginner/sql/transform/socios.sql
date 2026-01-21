INSERT INTO beginner.socios (
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
    faixa_etaria
)
SELECT DISTINCT
    cnpj_basico::CHAR(8),
    identificador_socio::SMALLINT,
    nome_socio::TEXT,
    cpf_cnpj_socio::TEXT,
    qualificacao_socio::INTEGER,
    data_entrada_sociedade::DATE,
    pais::INTEGER,
    representante_legal::TEXT,
    nome_representante::TEXT,
    qualificacao_representante::INTEGER,
    faixa_etaria::SMALLINT
FROM staging.socios
WHERE cnpj_basico IS NOT NULL
  AND identificador_socio IS NOT NULL
ON CONFLICT (cnpj_basico, identificador_socio) DO UPDATE
SET
    nome_socio = EXCLUDED.nome_socio,
    cpf_cnpj_socio = EXCLUDED.cpf_cnpj_socio,
    qualificacao_socio = EXCLUDED.qualificacao_socio,
    data_entrada_sociedade = EXCLUDED.data_entrada_sociedade,
    pais = EXCLUDED.pais,
    representante_legal = EXCLUDED.representante_legal,
    nome_representante = EXCLUDED.nome_representante,
    qualificacao_representante = EXCLUDED.qualificacao_representante,
    faixa_etaria = EXCLUDED.faixa_etaria
