from datetime import datetime
from airflow.sdk import dag, task

from intermediate.load import run_load
from intermediate.transform import run_transform


class Intermediate:
    def __init__(self):
        pass

    @dag(
        dag_id="intermediate_etl_dag",
        schedule="0 8 10 * *",
        start_date=datetime(2025, 1, 1),
        catchup=False,
    )
    def run():
        now = datetime.now()
        year = now.year
        # month = now.month
        month = 1

        @task()
        def extract_and_load():
            run_load(year, month)

        @task()
        def transform():
            run_transform()

        @task()
        def validate():
            pass
