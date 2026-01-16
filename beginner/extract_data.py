import requests
import zipfile
import io

CNPJ_DATA_URL = "https://arquivos.receitafederal.gov.br/dados/cnpj/dados_abertos_cnpj"


def base_extraction(
    year: int,
    zip_file_name: str,
    file_count: int,
    has_file_count: bool,
):
    for month in range(1, 13):
        for counter in range(file_count):
            formatted_month = f"{month:02d}"
            if has_file_count:
                file_name = f"{zip_file_name}{counter}"
            else:
                file_name = zip_file_name
            request_url = f"{CNPJ_DATA_URL}/{year}-{formatted_month}/{file_name}.zip"
            response = requests.get(request_url, stream=True)
            if response.status_code == 404:
                continue
            response.raise_for_status()

            try:
                zip_bytes = io.BytesIO(response.content)  # load into mem
                with zipfile.ZipFile(zip_bytes) as zf:
                    csv_name = zf.namelist()[0]
                    with zf.open(csv_name) as csv_file:
                        yield csv_file
            finally:
                response.close()
