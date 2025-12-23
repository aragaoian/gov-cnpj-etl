import requests
from datetime import date
import os
import zipfile
import io
from dotenv import load_dotenv

load_dotenv()

CNPJ_DATA_URL = "https://arquivos.receitafederal.gov.br/dados/cnpj/dados_abertos_cnpj/"
BASE_PATH = os.getenv("BASE_PATH")
DOWNLOAD_DIRECTORY = f"{BASE_PATH}\data"

res = requests.get(f"{CNPJ_DATA_URL}/2023-05/Cnaes.zip")

zip_data = io.BytesIO(res.content)

with zipfile.ZipFile(zip_data, "r") as archive:
    print("Files in archive:", archive.namelist())
    archive.extractall(DOWNLOAD_DIRECTORY)
    print(f"Files extracted to: {DOWNLOAD_DIRECTORY}")
