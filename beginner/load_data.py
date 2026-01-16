from beginner.extract_data import base_extraction
from database.session import DatabaseManager
from enums.db_schemas import Schemas_


def format_staging_insert_query(table_name: str) -> str:
    query = f"""
        COPY {Schemas_.STAGING.value}.{table_name}
        FROM STDIN
        WITH (
            FORMAT csv, 
            HEADER true,
            DELIMITER ';',
            QUOTE '"',
            ENCODING 'LATIN1'
        )
    """
    return query


def insert_data_staging(
    table_name: str, year: int, file_count: int = 1, has_file_count: bool = False
):
    table_to_insert = table_name.lower()
    zip_name_paramater = table_name.title()

    query = format_staging_insert_query(table_to_insert)
    with DatabaseManager() as cursor:
        for stream in base_extraction(
            year, zip_name_paramater, file_count, has_file_count
        ):
            cursor.copy_expert(query, stream)


def run_insertions_staging(year: int):
    insert_data_staging("cnaes", year)
    # insert_data_staging("empresas", year, 10, True)
    # insert_data_staging("estabelescimento", year, 10, True)
    # insert_data_staging("motivos", year)
    # insert_data_staging("municipios", year)
    # insert_data_staging("naturezas", year)
    # insert_data_staging("paises", year)
    # insert_data_staging("qualificacoes", year)
    # insert_data_staging("simples", year)
    # insert_data_staging("socios", year, 10, True)
