import requests
import os
import io
from dotenv import load_dotenv

load_dotenv()

CNPJ_DATA_URL = "https://arquivos.receitafederal.gov.br/dados/cnpj/dados_abertos_cnpj"
BASE_PATH = os.getenv("BASE_PATH")
DOWNLOAD_DIRECTORY = f"{BASE_PATH}\data"
YEARS_AVALIABLE = ["2023", "2024", "2025"]


def base_extraction(
    zip_file_name: str, file_count: int = 1, has_file_count: bool = False
):
    extracted_data_dict = {}
    for year in YEARS_AVALIABLE:
        monthly_extracted_data = []
        for month in range(1, 13):
            for counter in range(file_count):
                formatted_month = f"{month:02d}"
                if has_file_count:
                    file_name = f"{zip_file_name}{counter}"
                else:
                    file_name = zip_file_name
                response = requests.get(
                    f"{CNPJ_DATA_URL}/{year}-{formatted_month}/{file_name}.zip"
                )
                try:
                    monthly_extracted_data.append(io.BytesIO(response.content))
                except Exception as e:
                    raise Exception(
                        f"Unable to transform .zip due to an unexcepted error: {e}"
                    ) from e
        extracted_data_dict[year] = monthly_extracted_data
    return extracted_data_dict


def extract_cnaes():
    cnaes_zip = base_extraction("Cnaes")
    return cnaes_zip


def extract_empresas():
    empresas_zip = base_extraction("Empresas", 10, True)
    return empresas_zip


def extract_estabelescimentos():
    estabelescimentos_zip = base_extraction("Estabelescimento", 10, True)
    return estabelescimentos_zip


def extract_motivos():
    motivos_zip = base_extraction("Motivos")
    return motivos_zip


def extract_municipios():
    municipios_zip = base_extraction("Municipios")
    return municipios_zip


def extract_naturezas():
    naturezas_zip = base_extraction("Naturezas")
    return naturezas_zip


def extract_paises():
    paises_zip = base_extraction("Paises")
    return paises_zip


def extract_qualificacoes():
    qualificacoes_zip = base_extraction("Qualificacoes")
    return qualificacoes_zip


def extract_simples():
    simples_zip = base_extraction("Simples")
    return simples_zip


def extract_socios():
    socios_zip = base_extraction("Socios", 10, True)
    return socios_zip
