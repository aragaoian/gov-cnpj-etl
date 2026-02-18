import pandas as pd

from database.session import DatabaseManager


def active_companies_per_state() -> pd.DataFrame:
    query = """
        SELECT 
            uf, 
            COUNT(cnpj_basico)
        FROM staging.estabelecimentos
        GROUP BY uf
        ORDER BY uf ASC
    """

    with DatabaseManager() as cursor:
        conn = cursor.connection
        return pd.read_sql_query(query, conn)


def top_10_most_common_cnaes() -> pd.DataFrame:
    query = """
        SELECT
            cnaes.codigo,
            COUNT(estab.cnae_fiscal_principal)
        FROM staging.estabelecimentos AS estab
        INNER JOIN staging.cnaes AS cnaes
            ON cnaes.codigo = estab.cnae_fiscal_principal
        GROUP BY cnaes.codigo, estab.cnae_fiscal_principal
        ORDER BY COUNT(estab.cnae_fiscal_principal) DESC
        LIMIT 10
    """

    with DatabaseManager() as cursor:
        conn = cursor.connection
        return pd.read_sql_query(query, conn)


def distribution_by_company_size() -> pd.DataFrame:
    query = """
        SELECT
            CASE
                WHEN TRIM(emp.porte_empresa) IN ('00', '') THEN 'NÃO INFORMADO'
                WHEN TRIM(emp.porte_empresa) = '01' THEN 'ME'
                WHEN TRIM(emp.porte_empresa) = '03' THEN 'EPP'
                ELSE 'DEMAIS'
            END AS porte,
            TRUNC(
                (
                COUNT(emp.cnpj_basico)::FLOAT / 
                (SELECT COUNT(emp.cnpj_basico) FROM staging.empresas AS emp)::FLOAT 
                * 100
                )::NUMERIC, 3
            ) AS contagem
        FROM staging.empresas AS emp
        GROUP BY emp.porte_empresa
    """

    with DatabaseManager() as cursor:
        conn = cursor.connection
        return pd.read_sql_query(query, conn)
