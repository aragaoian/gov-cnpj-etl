INSERT INTO qualificacoes (codigo, descricao)
SELECT DISTINCT
    codigo::INTEGER,
    NULLIF(UPPER(descricao), '')::TEXT
FROM staging.qualificacoes
WHERE codigo IS NOT NULL
ON CONFLICT (codigo) DO UPDATE
SET descricao = EXCLUDED.descricao
