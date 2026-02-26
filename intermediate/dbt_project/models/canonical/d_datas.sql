{{ config(
    materialized='incremental',
    unique_key='codigo'
) }}


SELECT DISTINCT
    simples.data_opcao_simples::INTEGER AS codigo,
    parse_yyyymmdd_safe(simples.data_opcao_simples) AS data_completa
FROM {{ source('staging', 'simples') }} AS simples
UNION
SELECT DISTINCT
    simples.data_exclusao_simples::INTEGER AS codigo,
    parse_yyyymmdd_safe(simples.data_exclusao_simples) AS data_completa
FROM {{ source('staging', 'simples') }} AS simples
UNION
SELECT DISTINCT
    simples.data_opcao_mei::INTEGER AS codigo,
    parse_yyyymmdd_safe(simples.data_opcao_mei) AS data_completa
FROM {{ source('staging', 'simples') }} AS simples
UNION
SELECT DISTINCT
    simples.data_exclusao_mei::INTEGER AS codigo,
    parse_yyyymmdd_safe(simples.data_exclusao_mei) AS data_completa
FROM {{ source('staging', 'simples') }} AS simples

UNION

SELECT DISTINCT
    socios.data_entrada_sociedade::INTEGER AS codigo,
    parse_yyyymmdd_safe(socios.data_entrada_sociedade) AS data_completa
FROM {{ source('staging', 'socios') }} AS socios

UNION

SELECT DISTINCT
    estab.data_situacao_cadastral::INTEGER AS codigo,
    parse_yyyymmdd_safe(estab.data_situacao_cadastral) AS data_completa
FROM {{ source('staging', 'estabelecimentos') }} AS estab
UNION
SELECT DISTINCT
    estab.data_inicio_atividade::INTEGER AS codigo,
    parse_yyyymmdd_safe(estab.data_inicio_atividade) AS data_completa
FROM {{ source('staging', 'estabelecimentos') }} AS estab
UNION
SELECT DISTINCT
    estab.data_situacao_especial::INTEGER AS codigo,
    parse_yyyymmdd_safe(estab.data_situacao_especial) AS data_completa
FROM {{ source('staging', 'estabelecimentos') }} AS estab

{% if is_incremental() %}
    AND codigo NOT IN (SELECT codigo FROM {{ this }})
{% endif %}