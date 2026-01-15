import os
import psycopg2
from dotenv import load_dotenv

load_dotenv()

POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
POSTGRES_SCHEMA = os.getenv("POSTGRES_SCHEMA")
POSTGRES_HOST = os.getenv("POSTGRES_HOST")
POSTGRES_PORT = os.getenv("HOST_PORT")


class DatabaseManager:
    def __init__(self, database_name: str = "postgres"):
        self.database_name = database_name
        self.connection = None
        self.cursor = None

    def open_connection(self):
        try:
            conn = psycopg2.connect(
                dbname=self.database_name,
                user=POSTGRES_USER,
                password=POSTGRES_PASSWORD,
                host=POSTGRES_HOST,
                port=POSTGRES_PORT,
            )
            self.connection = conn
        except Exception as e:
            raise Exception(
                f"Error while trying to open database connection. {e}"
            ) from e

    def __enter__(self):
        self.open_connection()
        try:
            self.cursor = self.connection.cursor()
            return self.cursor
        except Exception as e:
            raise Exception(f"Error while creating the cursor. {e}") from e

    def __exit__(self, exc_type, exc, tb):
        try:
            if self.cursor:
                self.cursor.close()
            if self.connection:
                if exc_type:
                    self.connection.rollback()
                else:
                    self.connection.commit()
        finally:
            self.connection.close()
