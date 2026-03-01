{{ config(
    materialized='incremental',
    unique_key='codigo'
) }}


SELECT DISTINCT -- Known CNAEs from the source file
    cnaes.codigo::INTEGER AS codigo,
    NULLIF(UPPER(cnaes.descricao), '')::TEXT AS descricao,
    TRUE AS ativo
FROM {{ source('staging', 'cnaes') }} AS cnaes
WHERE cnaes.codigo IS NOT NULL

UNION

SELECT DISTINCT -- CNAEs referenced in estabelecimentos but missing from the cnaes source
    cnae_code::INTEGER AS codigo,
    NULL AS descricao,
    FALSE AS ativo
FROM (
    SELECT cnae_fiscal_principal AS cnae_code 
    FROM {{ source('staging', 'estabelecimentos') }}
    UNION
    SELECT TRIM(split_cnaes) AS cnae_code 
    FROM {{ source('staging', 'estabelecimentos') }}
    CROSS JOIN LATERAL STRING_TO_TABLE(cnae_fiscal_secundaria, ',') AS split_cnaes
) AS estab_cnaes
WHERE 
    cnae_code IS NOT NULL
    AND cnae_code <> ''
    AND cnae_code NOT IN (
        SELECT codigo FROM {{ source('staging', 'cnaes') }} WHERE codigo IS NOT NULL
    )

{% if is_incremental() %}
    AND codigo NOT IN (SELECT codigo FROM {{ this }})
{% endif %}