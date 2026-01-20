INSERT INTO beginner.cnaes (codigo, descricao)
SELECT DISTINCT
    codigo::INTEGER,
    descricao::TEXT
FROM staging.cnaes
WHERE codigo IS NOT NULL
ON CONFLICT (codigo) DO UPDATE
SET descricao = EXCLUDED.descricao