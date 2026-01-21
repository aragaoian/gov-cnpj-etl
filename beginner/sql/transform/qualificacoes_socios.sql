INSERT INTO beginner.qualificacoes (codigo, descricao)
SELECT DISTINCT
    codigo::INTEGER,
    descricao::TEXT
FROM staging.qualificacoes
WHERE codigo IS NOT NULL
ON CONFLICT (codigo) DO UPDATE
SET descricao = EXCLUDED.descricao
