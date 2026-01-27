ALTER TABLE qualificacoes
ADD COLUMN IF NOT EXISTS ativo BOOLEAN NOT NULL DEFAULT true;

INSERT INTO qualificacoes (codigo, descricao)
SELECT DISTINCT
    codigo::INTEGER,
    NULLIF(UPPER(descricao), '')::TEXT
FROM staging.qualificacoes
WHERE codigo IS NOT NULL
ON CONFLICT (codigo) DO UPDATE
SET descricao = EXCLUDED.descricao
