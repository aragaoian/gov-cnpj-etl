{{ config(
    materialized='incremental',
    unique_key='codigo'
) }}


SELECT DISTINCT -- Known Qualificações from the source file
    qualificacoes.codigo::INTEGER AS codigo,
    NULLIF(UPPER(qualificacoes.descricao), '')::TEXT AS descricao,
    TRUE AS ativo
FROM {{ source('staging', 'qualificacoes') }} AS qualificacoes
WHERE qualificacoes.codigo IS NOT NULL

UNION

SELECT DISTINCT -- Qualificações referenced in empresas, sócios but missing from the qualificações source
    qualificacao_code::INTEGER AS codigo,
    NULL AS descricao,
    FALSE AS ativo
FROM (
    SELECT qualificacao_responsavel AS qualificacao_code 
    FROM {{ source('staging', 'empresas') }}
    UNION
    SELECT qualificacao_socio AS qualificacao_code 
    FROM {{ source('staging', 'socios') }}
    UNION
    SELECT qualificacao_representante AS qualificacao_code 
    FROM {{ source('staging', 'socios') }}
) AS emp_socios_qualificacoes
WHERE 
    qualificacao_code IS NOT NULL
    AND qualificacao_code <> ''
    AND qualificacao_code NOT IN (
        SELECT codigo FROM {{ source('staging', 'qualificacoes') }} WHERE codigo IS NOT NULL
    )

{% if is_incremental() %}
    AND codigo NOT IN (SELECT codigo FROM {{ this }})
{% endif %}