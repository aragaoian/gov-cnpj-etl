from beginner.load_data import run_insertions_staging

YEARS_AVALIABLE = [2023, 2024, 2025]


def run_beginner():
    for year in YEARS_AVALIABLE:
        run_insertions_staging(year)
