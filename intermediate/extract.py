import requests
import zipfile
import tempfile
import io
import time

CNPJ_DATA_URL = (
    "https://arquivos.receitafederal.gov.br/public.php/dav/files/YggdBLfdninEJX9"
)
CHUNK_SIZE = 32768
MAX_RETRIES = 5
RETRY_DELAY = 10


def download_file(url: str, dest) -> bool:
    # After federal revenue changed
    # the way they stored and avaliability of
    # the files (running a .php server), there is
    # no safe and reliable way to download the files
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            downloaded = dest.tell()
            headers = {"Range": f"bytes={downloaded}-"} if downloaded > 0 else {}

            # Timeout with tuples
            # 30 seconds to connect to the server
            # 120 seconds for each chunk read
            with requests.get(
                url, stream=True, timeout=(10, 120), headers=headers
            ) as response:
                if response.status_code == 404:
                    return False

                # Server doesn't support Range
                # restart from scratch
                # 206 partial content
                if downloaded > 0 and response.status_code != 206:
                    dest.seek(0)
                    dest.truncate()

                response.raise_for_status()

                for chunk in response.iter_content(chunk_size=CHUNK_SIZE):
                    if chunk:
                        dest.write(chunk)

                dest.flush()
                return True

        except (
            requests.exceptions.ChunkedEncodingError,
            requests.exceptions.ConnectionError,
            requests.exceptions.Timeout,
        ) as e:
            current = dest.tell()
            if attempt < MAX_RETRIES:
                wait = RETRY_DELAY * attempt
                print(
                    f"Download failed at {current / CHUNK_SIZE:.1f} MB "
                    f"(attempt {attempt}/{MAX_RETRIES}): {e}"
                )
                print(f"Resuming in {wait}s...")
                time.sleep(wait)
            else:
                raise


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

        with tempfile.NamedTemporaryFile(suffix=".zip", delete=True) as tmp:
            downloaded_file = download_file(request_url, tmp)

            if not downloaded_file:
                if has_file_count and no_files_found_counter < 2:
                    no_files_found_counter += 1
                    continue
                break

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
