{{ config(
    materialized='incremental',
    unique_key='codigo'
) }}


SELECT DISTINCT -- Known Naturezas from the source file
    naturezas.codigo::INTEGER AS codigo,
    NULLIF(UPPER(naturezas.descricao), '')::TEXT AS descricao,
    TRUE AS ativo
FROM {{ source('staging', 'naturezas') }} AS naturezas
WHERE naturezas.codigo IS NOT NULL

UNION

SELECT DISTINCT -- Naturezas referenced in empresas but missing from the naturezas source
    natureza_code::INTEGER AS codigo,
    NULL AS descricao,
    FALSE AS ativo
FROM (
    SELECT natureza_juridica AS natureza_code 
    FROM {{ source('staging', 'empresas') }}
) AS emp_naturezas
WHERE 
    natureza_code IS NOT NULL
    AND natureza_code <> ''
    AND natureza_code NOT IN (
        SELECT codigo FROM {{ source('staging', 'naturezas') }} WHERE codigo IS NOT NULL
    )

{% if is_incremental() %}
    AND codigo NOT IN (SELECT codigo FROM {{ this }})
{% endif %}