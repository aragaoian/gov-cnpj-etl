INSERT INTO motivos (codigo, descricao)
SELECT DISTINCT
    codigo::INTEGER,
    NULLIF(UPPER(descricao), '')::TEXT
FROM staging.motivos
WHERE codigo IS NOT NULL
ON CONFLICT (codigo) DO UPDATE
SET descricao = EXCLUDED.descricao
