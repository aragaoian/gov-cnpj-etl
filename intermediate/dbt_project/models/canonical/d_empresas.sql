{{ config(
    materialized='incremental',
    unique_key='cnpj_basico',
    post_hook="""
        UPDATE {{ this }}
        SET ativo = FALSE
        WHERE
            ativo = TRUE
            AND NOT EXISTS (
                SELECT 1
                FROM staging.empresas stg_emp
                WHERE stg_emp.cnpj_basico = {{ this }}.cnpj_basico
            )
    """
) }}

-- Conditions
-- 1. if cnpj_basico exists in staging but not in canonical -> add record and activate row
-- 2. if cnpj_basico exists in staging and in canonical -> update record and keep row activated
-- 3. if cnpj_basico exists in staging and in canonical (but it is deactivated) -> update record and activate the record
-- 4. if cnpj_basico does not exist in staging and exists in canonical -> deactivate record in canonical


SELECT DISTINCT
    empresas.cnpj_basico::VARCHAR(8) AS cnpj_basico,
    NULLIF(empresas.razao_social, '')::TEXT AS razao_social,
    NULLIF(empresas.natureza_juridica, '')::INTEGER AS natureza_juridica,
    NULLIF(empresas.qualificacao_responsavel, '')::INTEGER AS qualificacao_responsavel,
    NULLIF(REPLACE(empresas.capital_social, ',', '.'), '')::NUMERIC AS capital_social,
    NULLIF(empresas.porte_empresa, '')::SMALLINT AS porte_empresa,
    NULLIF(empresas.ente_federativo_responsavel, '')::TEXT AS ente_federativo_responsavel,
    TRUE AS ativo
FROM {{ source('staging', 'empresas') }} AS empresas
WHERE 
    empresas.cnpj_basico IS NOT NULL