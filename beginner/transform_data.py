from database.session import DatabaseManager
import os

"""
TODO
1. Move from staging to real table
2. delete duplicates
3. insert year
"""

TRANSFORMS = {
    "cnaes": "transform/sql/cnaes.sql",
    "empresas": "transform/sql/empresas.sql",
    "estabelecimentos": "transform/sql/estabelecimentos.sql",
    "socios": "transform/sql/socios.sql",
    "simples": "transform/sql/simples.sql",
    "paises": "transform/sql/paises.sql",
    "municipios": "transform/sql/municipios.sql",
    "naturezas_juridicas": "transform/sql/naturezas_juridicas.sql",
    "qualificacoes_socios": "transform/sql/qualificacoes_socios.sql",
    "motivos": "transform/sql/motivos.sql",
}
BASE_DIRECTORY = os.getcwd()


def move_delete_duplicates(table_name: str):
    sql_file = TRANSFORMS[table_name]
    query = (f"{BASE_DIRECTORY}/{sql_file}").read_text(encoding="utf-8")

    with DatabaseManager() as cursor:
        cursor.execute(query)


def run_transform():
    for table_name in TRANSFORMS:
        move_delete_duplicates(table_name)
