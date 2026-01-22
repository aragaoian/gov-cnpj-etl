INSERT INTO empresas (cnpj_basico, razao_social, natureza_juridica, qualificacao_responsavel, capital_social, porte_empresa, ente_federativo_responsavel)
SELECT DISTINCT
    cnpj_basico::CHAR(8),
    NULLIF(razao_social, '')::TEXT,
    NULLIF(natureza_juridica, '')::INTEGER,
    NULLIF(qualificacao_responsavel, '')::INTEGER,
    NULLIF(REPLACE(capital_social, ',', '.'), '')::NUMERIC,
    NULLIF(porte_empresa, '')::SMALLINT,
    NULLIF(ente_federativo_responsavel, '')::TEXT
FROM staging.empresas
WHERE cnpj_basico IS NOT NULL
ON CONFLICT (cnpj_basico) DO UPDATE
SET
    razao_social = EXCLUDED.razao_social,
    natureza_juridica = EXCLUDED.natureza_juridica,
    qualificacao_responsavel = EXCLUDED.qualificacao_responsavel,
    capital_social = EXCLUDED.capital_social,
    porte_empresa = EXCLUDED.porte_empresa,
    ente_federativo_responsavel = EXCLUDED.ente_federativo_responsavel
