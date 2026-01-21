INSERT INTO beginner.motivos (codigo, descricao)
SELECT DISTINCT
    codigo::INTEGER,
    descricao::TEXT
FROM staging.motivos
WHERE codigo IS NOT NULL
ON CONFLICT (codigo) DO UPDATE
SET descricao = EXCLUDED.descricao
