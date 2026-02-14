ALTER TABLE empresas
ADD COLUMN IF NOT EXISTS ativo BOOLEAN NOT NULL DEFAULT true;

-- Address issues with inactive qualifications
INSERT INTO qualificacoes (codigo, descricao, ativo)
SELECT DISTINCT
    emp.qualificacao_responsavel::INTEGER,
    'N/A',
    false
FROM staging.empresas AS emp
LEFT JOIN qualificacoes AS qlf
    ON emp.qualificacao_responsavel::INTEGER = qlf.codigo
WHERE
    qlf.codigo IS NULL
    AND emp.qualificacao_responsavel IS NOT NULL;


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
    ente_federativo_responsavel = EXCLUDED.ente_federativo_responsavel;
