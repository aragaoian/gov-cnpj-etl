import requests
import zipfile
import tempfile
import io

CNPJ_DATA_URL = "https://arquivos.receitafederal.gov.br/dados/cnpj/dados_abertos_cnpj"


def run_extraction(
    year: int,
    month: int,
    zip_file_name: str,
    file_count: int,
    has_file_count: bool,
):
    no_files_found_counter = 0

    for counter in range(file_count):
        formatted_month = f"{month:02d}"
        file_name = f"{zip_file_name}{counter}" if has_file_count else zip_file_name
        request_url = f"{CNPJ_DATA_URL}/{year}-{formatted_month}/{file_name}.zip"

        with requests.get(request_url, stream=True, timeout=60) as response:
            if response.status_code == 404:
                if has_file_count and no_files_found_counter < 2:
                    no_files_found_counter += 1
                    continue
                break

            response.raise_for_status()

            with tempfile.NamedTemporaryFile(suffix=".zip", delete=True) as tmp:
                for chunk in response.iter_content(chunk_size=4096):
                    if chunk:
                        tmp.write(chunk)

                tmp.flush()
                tmp.seek(0)

                with zipfile.ZipFile(tmp.name) as zf:
                    csv_name = zf.namelist()[0]
                    data = zf.read(csv_name)
                    # Sanitize bytes to remove NUL character
                    # PostgreSQL does not support it
                    data = data.replace(b"\x00", b"")

                # Yielding streams outsite of a with block creates a safer function
                # because with blocks will close when the generator resumes
                # causing reading blocks, stalled generators, etc.
                yield io.BytesIO(data)
