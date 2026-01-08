import os
import psycopg2

POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
POSTGRES_SCHEMA = os.getenv("POSTGRES_SCHEMA")
POSTGRES_HOST = os.getenv("POSTGRES_HOST")
POSTGRES_PORT = os.getenv("HOST_PORT")


class DatabaseManager:
    def __init__(self, database: str):
        self.database_name = database
        self.session = None

    # TODO
    # session is the connection
    # implement commit, rollback and close
    # fix __enter__ method

    def open_connection(self):
        try:
            conn = psycopg2.connect(
                dbname=self.database_name,
                user=POSTGRES_USER,
                password=POSTGRES_PASSWORD,
                host=POSTGRES_HOST,
                port=POSTGRES_PORT,
            )
            return conn
        except Exception as e:
            raise Exception(f"Error while trying to open database connection. {e}")

    def __enter__(self):
        conn = self.open_connection()
        try:
            self.session = conn.cursor()
            return self.session
        except Exception as e:
            raise Exception(f"Error while creating the session. {e}")

    def __exit__(self):
        if self.session:
            self.session.comm
