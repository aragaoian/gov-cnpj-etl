INSERT INTO beginner.simples (cnpj_basico, opcao_simples, data_opcao_simples, data_exclusao_simples, opcao_mei, data_opcao_mei, data_exclusao_mei)
SELECT DISTINCT
    cnpj_basico::CHAR(8),
    opcao_simples::CHAR(1),
    data_opcao_simples::DATE,
    data_exclusao_simples::DATE,
    opcao_mei::CHAR(1),
    data_opcao_mei::DATE,
    data_exclusao_mei::DATE
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
