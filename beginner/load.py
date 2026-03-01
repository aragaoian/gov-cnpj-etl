from beginner.extract import run_extraction
from database.session import DatabaseManager
from tqdm import tqdm


def format_staging_insert_query(table_name: str) -> str:
    query = f"""
        COPY staging.{table_name}
        FROM STDIN
        WITH (
            FORMAT csv, 
            HEADER false,
            DELIMITER ';',
            QUOTE '"',
            ENCODING 'LATIN1'
        )
    """
    return query


def insert_data_staging(
    table_name: str,
    year: int,
    month: int,
    file_count: int = 1,
    has_file_count: bool = False,
) -> None:
    table_to_insert = table_name.lower()
    zip_name_paramater = table_name.title()

    query = format_staging_insert_query(table_to_insert)
    streams = run_extraction(
        year, month, zip_name_paramater, file_count, has_file_count
    )

    with DatabaseManager() as cursor:
        for stream in tqdm(
            streams,
            total=file_count,
            desc=f"Processing {table_name}",
            ncols=150,
            mininterval=0.5,
        ):
            cursor.copy_expert(query, stream)
            cursor.connection.commit()


def run_load(year: int, month: int) -> None:
    """
    These insertions will take longer due to bigger csv's ( > 500MB):
    1. empresas
    2. estabelecimentos
    3. simples
    4. socios
    """
    # insert_data_staging("cnaes", year, month)
    # insert_data_staging("motivos", year, month)
    # insert_data_staging("municipios", year, month)
    # insert_data_staging("naturezas", year, month)
    # insert_data_staging("paises", year, month)
    # insert_data_staging("qualificacoes", year, month)
    # insert_data_staging("simples", year, month)
    # insert_data_staging("empresas", year, month, 10, True)
    insert_data_staging("estabelecimentos", year, month, 10, True)
    # insert_data_staging("socios", year, month, 10, True)
