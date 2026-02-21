-- Address issues with inactive qualifications
INSERT INTO d_empresas (cnpj_basico, razao_social, natureza_juridica, ativo)
SELECT DISTINCT
    sim.cnpj_basico::TEXT,
    'N/A',
    0,
    false
FROM staging.simples AS sim
LEFT JOIN d_empresas AS emp
    ON sim.cnpj_basico::TEXT = emp.cnpj_basico
WHERE
    emp.cnpj_basico IS NULL
    AND sim.cnpj_basico IS NOT NULL;

INSERT INTO d_simples (cnpj_basico, opcao_simples, data_opcao_simples, data_exclusao_simples, opcao_mei, data_opcao_mei, data_exclusao_mei)
SELECT DISTINCT
    cnpj_basico::CHAR(8),
    NULLIF(opcao_simples, '')::CHAR(1),
    parse_yyyymmdd_safe(data_opcao_simples),
    parse_yyyymmdd_safe(data_exclusao_simples),
    NULLIF(opcao_mei, '')::CHAR(1),
    parse_yyyymmdd_safe(data_opcao_mei),
    parse_yyyymmdd_safe(data_exclusao_mei)
FROM staging.simples
WHERE cnpj_basico IS NOT NULL
ON CONFLICT (cnpj_basico) DO UPDATE
SET
    opcao_simples = EXCLUDED.opcao_simples,
    data_opcao_simples = EXCLUDED.data_opcao_simples,
    data_exclusao_simples = EXCLUDED.data_exclusao_simples,
    opcao_mei = EXCLUDED.opcao_mei,
    data_opcao_mei = EXCLUDED.data_opcao_mei,
    data_exclusao_mei = EXCLUDED.data_exclusao_mei
