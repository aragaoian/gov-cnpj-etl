-- psycopg2.errors.ForeignKeyViolation: insert or update on table "estabelecimentos" 
-- violates foreign key constraint "pais_fk"
-- DETAIL:  Key (pais)=(367) is not present in table "paises".

INSERT INTO d_paises (codigo, descricao, ativo)
SELECT DISTINCT
    TRIM(etblcm.pais)::INTEGER,
    'N/A',
    false
FROM staging.estabelecimentos AS etblcm
LEFT JOIN d_paises AS paises
    ON paises.codigo::TEXT = TRIM(etblcm.pais)
WHERE
    paises.codigo IS NULL
    AND etblcm.pais IS NOT NULL
    AND TRIM(etblcm.pais) <> '';

INSERT INTO f_estabelecimentos (
    cnpj_basico,
    cnpj_ordem,
    cnpj_dv,
    identificador_matriz_filial,
    nome_fantasia,
    situacao_cadastral,
    data_situacao_cadastral,
    motivo_situacao_cadastral,
    nome_cidade_exterior,
    pais,
    data_inicio_atividade,
    cnae_fiscal_principal,
    cnae_fiscal_secundaria,
    tipo_logradouro,
    logradouro,
    numero,
    complemento,
    bairro,
    cep,
    uf,
    municipio,
    ddd1,
    telefone1,
    ddd2,
    telefone2,
    ddd_fax,
    fax,
    correio_eletronico,
    situacao_especial,
    data_situacao_especial
)
SELECT DISTINCT
    cnpj_basico::CHAR(8),
    cnpj_ordem::CHAR(4),
    cnpj_dv::CHAR(2),
    identificador_matriz_filial::SMALLINT,
    NULLIF(nome_fantasia, '')::TEXT,
    NULLIF(situacao_cadastral, '')::SMALLINT,
    parse_yyyymmdd_safe(data_situacao_cadastral),
    NULLIF(motivo_situacao_cadastral, '')::INTEGER,
    NULLIF(nome_cidade_exterior, '')::TEXT,
    NULLIF(pais, '')::INTEGER,
    parse_yyyymmdd_safe(data_inicio_atividade),
    NULLIF(cnae_fiscal_principal, '')::INTEGER,
    NULLIF(cnae_fiscal_secundaria, '')::TEXT,
    NULLIF(tipo_logradouro, '')::TEXT,
    NULLIF(logradouro, '')::TEXT,
    NULLIF(numero, '')::TEXT,
    NULLIF(complemento, '')::TEXT,
    NULLIF(bairro, '')::TEXT,
    NULLIF(cep, '')::CHAR(8),
    NULLIF(uf, '')::CHAR(2),
    NULLIF(municipio, '')::INTEGER,
    NULLIF(ddd1, '')::CHAR(2),
    NULLIF(telefone1, '')::TEXT,
    NULLIF(ddd2, '')::CHAR(2),
    NULLIF(telefone2, '')::TEXT,
    NULLIF(ddd_fax, '')::CHAR(2),
    NULLIF(fax, '')::TEXT,
    NULLIF(correio_eletronico, '')::TEXT,
    NULLIF(situacao_especial, '')::TEXT,
    parse_yyyymmdd_safe(data_situacao_especial)
FROM staging.estabelecimentos
WHERE cnpj_basico IS NOT NULL
  AND cnpj_ordem IS NOT NULL
  AND cnpj_dv IS NOT NULL
ON CONFLICT (cnpj_basico, cnpj_ordem, cnpj_dv) DO UPDATE
SET
    identificador_matriz_filial = EXCLUDED.identificador_matriz_filial,
    nome_fantasia = EXCLUDED.nome_fantasia,
    situacao_cadastral = EXCLUDED.situacao_cadastral,
    data_situacao_cadastral = EXCLUDED.data_situacao_cadastral,
    motivo_situacao_cadastral = EXCLUDED.motivo_situacao_cadastral,
    nome_cidade_exterior = EXCLUDED.nome_cidade_exterior,
    pais = EXCLUDED.pais,
    data_inicio_atividade = EXCLUDED.data_inicio_atividade,
    cnae_fiscal_principal = EXCLUDED.cnae_fiscal_principal,
    cnae_fiscal_secundaria = EXCLUDED.cnae_fiscal_secundaria,
    tipo_logradouro = EXCLUDED.tipo_logradouro,
    logradouro = EXCLUDED.logradouro,
    numero = EXCLUDED.numero,
    complemento = EXCLUDED.complemento,
    bairro = EXCLUDED.bairro,
    cep = EXCLUDED.cep,
    uf = EXCLUDED.uf,
    municipio = EXCLUDED.municipio,
    ddd1 = EXCLUDED.ddd1,
    telefone1 = EXCLUDED.telefone1,
    ddd2 = EXCLUDED.ddd2,
    telefone2 = EXCLUDED.telefone2,
    ddd_fax = EXCLUDED.ddd_fax,
    fax = EXCLUDED.fax,
    correio_eletronico = EXCLUDED.correio_eletronico,
    situacao_especial = EXCLUDED.situacao_especial,
    data_situacao_especial = EXCLUDED.data_situacao_especial