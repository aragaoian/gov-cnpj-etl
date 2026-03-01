{{ config(
    materialized='incremental',
    unique_key='codigo'
) }}


SELECT DISTINCT -- Known Motivos from the source file
    motivos.codigo::INTEGER AS codigo,
    NULLIF(UPPER(motivos.descricao), '')::TEXT AS descricao,
    TRUE AS ativo
FROM {{ source('staging', 'motivos') }} AS motivos
WHERE motivos.codigo IS NOT NULL>

UNION

SELECT DISTINCT -- Motivos referenced in estabelecimentos but missing from the motivos source
    motivo_code::INTEGER AS codigo,
    NULL AS descricao,
    FALSE AS ativo
FROM (
    SELECT motivo_situacao_cadastral AS motivo_code 
    FROM {{ source('staging', 'estabelecimentos') }}
) AS estab_motivos
WHERE 
    motivo_code IS NOT NULL
    AND motivo_code <> ''
    AND motivo_code NOT IN (
        SELECT codigo FROM {{ source('staging', 'motivos') }} WHERE codigo IS NOT NULL
    )

{% if is_incremental() %}
    AND codigo NOT IN (SELECT codigo FROM {{ this }})
{% endif %}