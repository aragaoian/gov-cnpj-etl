INSERT INTO simples (cnpj_basico, opcao_simples, data_opcao_simples, data_exclusao_simples, opcao_mei, data_opcao_mei, data_exclusao_mei)
SELECT DISTINCT
    cnpj_basico::CHAR(8),
    NULLIF(opcao_simples, '')::CHAR(1),
    NULLIF(data_opcao_simples, '')::DATE,
    NULLIF(data_exclusao_simples, '')::DATE,
    NULLIF(opcao_mei, '')::CHAR(1),
    NULLIF(data_opcao_mei, '')::DATE,
    NULLIF(data_exclusao_mei, '')::DATE
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
