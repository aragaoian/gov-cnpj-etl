{{ config(
    materialized='incremental',
    unique_key='codigo'
) }}


SELECT DISTINCT -- Known Países from the source file
    paises.codigo::INTEGER AS codigo,
    NULLIF(UPPER(paises.descricao), '')::TEXT AS descricao,
    TRUE AS ativo
FROM {{ source('staging', 'paises') }} AS paises
WHERE paises.codigo IS NOT NULL

UNION

SELECT DISTINCT -- Países referenced in estabelecimentos but missing from the países source
    pais_code::INTEGER AS codigo,
    NULL AS descricao,
    FALSE AS ativo
FROM (
    SELECT pais AS pais_code 
    FROM {{ source('staging', 'estabelecimentos') }}
) AS estab_paises
WHERE 
    pais_code IS NOT NULL
    AND pais_code <> ''
    AND pais_code NOT IN (
        SELECT codigo FROM {{ source('staging', 'paises') }} WHERE codigo IS NOT NULL
    )

{% if is_incremental() %}
    AND codigo NOT IN (SELECT codigo FROM {{ this }})
{% endif %}