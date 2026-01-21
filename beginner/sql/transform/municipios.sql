INSERT INTO beginner.municipios (codigo, descricao)
SELECT DISTINCT
    codigo::INTEGER,
    descricao::TEXT
FROM staging.municipios
WHERE codigo IS NOT NULL
ON CONFLICT (codigo) DO UPDATE
SET descricao = EXCLUDED.descricao
