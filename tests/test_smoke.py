import duckdb


def test_duckdb_smoke():
    assert duckdb.sql("select 40 + 2").fetchone()[0] == 42