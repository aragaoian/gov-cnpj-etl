INSERT INTO beginner.naturezas (codigo, descricao)
SELECT DISTINCT
    codigo::INTEGER,
    descricao::TEXT
FROM staging.naturezas
WHERE codigo IS NOT NULL
ON CONFLICT (codigo) DO UPDATE
SET descricao = EXCLUDED.descricao
