from datetime import datetime
from beginner.load_data import run_load


class Beginner:
    def __init__(self):
        pass

    @staticmethod
    def run():
        now = datetime.now()
        year = now.year
        month = now.month

        run_load(year, month)
