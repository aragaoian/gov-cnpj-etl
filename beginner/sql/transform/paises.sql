INSERT INTO paises (codigo, descricao)
SELECT DISTINCT
    codigo::INTEGER,
    NULLIF(UPPER(descricao), '')::TEXT
FROM staging.paises
WHERE codigo IS NOT NULL
ON CONFLICT (codigo) DO UPDATE
SET descricao = EXCLUDED.descricao
