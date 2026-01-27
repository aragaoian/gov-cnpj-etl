from database.session import DatabaseManager
from pathlib import Path
import os


BASE_DIRECTORY = os.getcwd()
TRANSFORM_PATH = "beginner/sql/transform"
CONSTRAINTS_PATH = "database/constraints"

TRANSFORMS = {
    # "cnaes": f"{TRANSFORM_PATH}/cnaes.sql",
    # "paises": f"{TRANSFORM_PATH}/paises.sql",
    # "municipios": f"{TRANSFORM_PATH}/municipios.sql",
    # "naturezas_juridicas": f"{TRANSFORM_PATH}/naturezas_juridicas.sql",
    # "qualificacoes_socios": f"{TRANSFORM_PATH}/qualificacoes_socios.sql",
    # "motivos": f"{TRANSFORM_PATH}/motivos.sql",
    # "empresas": f"{TRANSFORM_PATH}/empresas.sql",
    "estabelecimentos": f"{TRANSFORM_PATH}/estabelecimentos.sql",
    "simples": f"{TRANSFORM_PATH}/simples.sql",
    "socios": f"{TRANSFORM_PATH}/socios.sql",
}
CONSTRAINTS = {
    # "cnaes": None,
    # "paises": None,
    # "municipios": None,
    # "naturezas_juridicas": None,
    # "qualificacoes_socios": None,
    # "motivos": None,
    # "empresas": f"{CONSTRAINTS_PATH}/empresas_constraints.sql",
    "estabelecimentos": f"{CONSTRAINTS_PATH}/estabelecimentos_constraints.sql",
    "simples": f"{CONSTRAINTS_PATH}/simples_constraints.sql",
    "socios": f"{CONSTRAINTS_PATH}/socios_constraints.sql",
}


def read_sql_file(path_dict: dict, table_name: str) -> None:
    sql_file = path_dict[table_name]
    if not sql_file:
        return
    path = Path(f"{BASE_DIRECTORY}/{sql_file}")
    query = path.read_text(encoding="utf-8")

    with DatabaseManager() as cursor:
        cursor.execute(query)


def run_transform():
    for table_name in TRANSFORMS:
        print(f"Moving {table_name} data from staging to cannonical")
        read_sql_file(TRANSFORMS, table_name)
        print(f"Creating constraints for {table_name}")
        read_sql_file(CONSTRAINTS, table_name)
