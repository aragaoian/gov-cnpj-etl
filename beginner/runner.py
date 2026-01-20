from beginner.load_data import run_load
from beginner.transform_data import run_transform
from datetime import datetime


def run_beginner():
    now = datetime.now()
    year = now.year
    month = now.month

    run_load(year, month)
    # run_transform()
