{{ config(
    materialized='incremental',
    unique_key='codigo'
) }}


SELECT DISTINCT -- Known Municípios from the source file
    municipios.codigo::INTEGER AS codigo,
    NULLIF(UPPER(municipios.descricao), '')::TEXT AS descricao,
    TRUE AS ativo
FROM {{ source('staging', 'municipios') }} AS municipios
WHERE municipios.codigo IS NOT NULL

UNION

SELECT DISTINCT -- Municípios referenced in estabelecimentos but missing from the municipios source
    municipio_code::INTEGER AS codigo,
    NULL AS descricao,
    FALSE AS ativo
FROM (
    SELECT municipio AS municipio_code 
    FROM {{ source('staging', 'estabelecimentos') }}
) AS estab_municipios
WHERE 
    municipio_code IS NOT NULL
    AND municipio_code <> ''
    AND municipio_code NOT IN (
        SELECT codigo FROM {{ source('staging', 'municipios') }} WHERE codigo IS NOT NULL
    )

{% if is_incremental() %}
    AND codigo NOT IN (SELECT codigo FROM {{ this }})
{% endif %}