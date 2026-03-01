ALTER TABLE d_paises
ADD COLUMN IF NOT EXISTS ativo BOOLEAN NOT NULL DEFAULT true;

INSERT INTO d_paises (codigo, descricao)
SELECT DISTINCT
    codigo::INTEGER,
    NULLIF(UPPER(descricao), '')::TEXT
FROM staging.paises
WHERE codigo IS NOT NULL
ON CONFLICT (codigo) DO UPDATE
SET descricao = EXCLUDED.descricao
