from pathlib import Path

import duckdb


PROJECT_ROOT = Path(__file__).resolve().parents[1]
CSV_PATH = PROJECT_ROOT / "data" / "raw" / "nyc311_2024_q1.csv"
DB_PATH = PROJECT_ROOT / "data" / "warehouse.duckdb"

if not CSV_PATH.exists():
    raise FileNotFoundError(f"Dataset not found: {CSV_PATH}")

csv_for_sql = CSV_PATH.as_posix().replace("'", "''")

with duckdb.connect(str(DB_PATH)) as con:
    con.execute(
        f"""
        CREATE OR REPLACE TABLE raw_311 AS
        SELECT *
        FROM read_csv_auto(
            '{csv_for_sql}',
            header = true,
            sample_size = -1
        );
        """
    )

    row_count = con.execute("SELECT COUNT(*) FROM raw_311").fetchone()[0]
    column_count = len(con.execute("DESCRIBE raw_311").fetchall())

    print(f"Loaded {row_count:,} rows and {column_count} columns.")
    print(f"Database saved at: {DB_PATH}")