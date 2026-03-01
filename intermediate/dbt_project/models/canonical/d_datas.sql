{{ config(
    materialized='incremental',
    unique_key='codigo'
) }}

SELECT DISTINCT
    codigo,
    data_completa,
    EXTRACT(YEAR FROM data_completa)::INTEGER AS ano,
    EXTRACT(QUARTER FROM data_completa)::INTEGER AS trimestre,
    EXTRACT(MONTH FROM data_completa)::INTEGER AS mes,
    EXTRACT(DAY FROM data_completa)::INTEGER AS dia,
    CASE EXTRACT(MONTH FROM data_completa)::INTEGER
        WHEN 1  THEN 'Janeiro'
        WHEN 2  THEN 'Fevereiro'
        WHEN 3  THEN 'Março'
        WHEN 4  THEN 'Abril'
        WHEN 5  THEN 'Maio'
        WHEN 6  THEN 'Junho'
        WHEN 7  THEN 'Julho'
        WHEN 8  THEN 'Agosto'
        WHEN 9  THEN 'Setembro'
        WHEN 10 THEN 'Outubro'
        WHEN 11 THEN 'Novembro'
        WHEN 12 THEN 'Dezembro'
    END AS nome_mes,
    CASE EXTRACT(DOW FROM data_completa)::INTEGER
        WHEN 0 THEN 'Domingo'
        WHEN 1 THEN 'Segunda-feira'
        WHEN 2 THEN 'Terça-feira'
        WHEN 3 THEN 'Quarta-feira'
        WHEN 4 THEN 'Quinta-feira'
        WHEN 5 THEN 'Sexta-feira'
        WHEN 6 THEN 'Sábado'
    END AS nome_dia,
    CASE
        WHEN EXTRACT(DOW FROM data_completa)::INTEGER NOT IN (0, 6)
        THEN TRUE
        ELSE FALSE
    END AS dia_de_semana
FROM (
    -- Simples
    SELECT DISTINCT
        NULLIF(simples.data_opcao_simples, '')::INTEGER AS codigo,
        parse_yyyymmdd_safe(simples.data_opcao_simples) AS data_completa
    FROM {{ source('staging', 'simples') }} AS simples
    UNION
    SELECT DISTINCT
        NULLIF(simples.data_exclusao_simples, '')::INTEGER AS codigo,
        parse_yyyymmdd_safe(simples.data_exclusao_simples) AS data_completa
    FROM {{ source('staging', 'simples') }} AS simples
    UNION
    SELECT DISTINCT
        NULLIF(simples.data_opcao_mei, '')::INTEGER AS codigo,
        parse_yyyymmdd_safe(simples.data_opcao_mei) AS data_completa
    FROM {{ source('staging', 'simples') }} AS simples
    UNION
    SELECT DISTINCT
        NULLIF(simples.data_exclusao_mei, '')::INTEGER AS codigo,
        parse_yyyymmdd_safe(simples.data_exclusao_mei) AS data_completa
    FROM {{ source('staging', 'simples') }} AS simples

    UNION
    -- Sócios
    SELECT DISTINCT
        NULLIF(socios.data_entrada_sociedade, '')::INTEGER AS codigo,
        parse_yyyymmdd_safe(socios.data_entrada_sociedade) AS data_completa
    FROM {{ source('staging', 'socios') }} AS socios

    UNION
    -- Estabelecimentos
    SELECT DISTINCT
        NULLIF(estab.data_situacao_cadastral, '')::INTEGER AS codigo,
        parse_yyyymmdd_safe(estab.data_situacao_cadastral) AS data_completa
    FROM {{ source('staging', 'estabelecimentos') }} AS estab
    UNION
    SELECT DISTINCT
        NULLIF(estab.data_inicio_atividade, '')::INTEGER AS codigo,
        parse_yyyymmdd_safe(estab.data_inicio_atividade) AS data_completa
    FROM {{ source('staging', 'estabelecimentos') }} AS estab
    UNION
    SELECT DISTINCT
        NULLIF(estab.data_situacao_especial, '')::INTEGER AS codigo,
        parse_yyyymmdd_safe(estab.data_situacao_especial) AS data_completa
    FROM {{ source('staging', 'estabelecimentos') }} AS estab
) AS base
WHERE
    codigo IS NOT NULL
    AND LENGTH(codigo::TEXT) = 8

{% if is_incremental() %}
    AND codigo NOT IN (SELECT codigo FROM {{ this }})
{% endif %}