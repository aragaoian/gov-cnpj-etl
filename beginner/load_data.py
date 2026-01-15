from beginner.extract_data import base_extraction
from database.session import DatabaseManager
from enums.db_schemas import Schemas_

"""
    TODO
    1. create a staging schema
    2. upload to staging and then upload to the true table with related_year
"""


def format_staging_insert_query(table_name: str) -> str:
    query = f"""
        COPY {Schemas_.STAGING.value}.{table_name}
        FROM STDIN
        WITH (FORMAT csv, HEADER true)
    """
    return query


def insert_cnaes(year: int):
    query = format_staging_insert_query("cnaes")
    with DatabaseManager() as cursor:
        for stream in base_extraction(year, zip_file_name="Cnaes"):
            cursor.copy_expert(query, stream)
