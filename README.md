# Data Engineer Transition

A hands-on six-month transition portfolio focused on modern Data Engineering.

## Target profile

Data Engineer with strong SQL, Python, Spark, data modelling, orchestration, testing, and analytics-engineering depth.

## Current phase

Week 1: local development setup, SQL baseline, Python baseline, and City Operations data-model design.

## Local setup

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements-dev.txt
python -m pytest

```

> **Setup verification:** These commands reflect the initial Week 1 setup. A fresh-terminal verification is pending because the local Python installation and existing virtual environment need repair. This will be completed during `d06`.

## Week 1 evidence

- [Week 1 baseline findings](docs/week1_baseline_findings.md)
- [Baseline SQL](01_sql/diagnostics/w1_baseline.sql)
- [Invalid closure investigation](01_sql/diagnostics/w1_invalid_closure_records.sql)
- [Clean-layer rules](docs/city_ops_clean_layer_rules.md)
- [NYC 311 load script](scripts/load_311.py)
- [Smoke test](tests/test_smoke.py)

## Dataset scope

The intended scope was Q1 2024, but the current 50,000-row extract covers only 25–31 March 2024 because of the extraction limit. Results describe this bounded sample and must not be presented as quarter-wide or month-over-month findings.

The sample contains 708 requests without a closure timestamp and 15 records where closure precedes creation. These records remain in the raw data and are handled using the documented [clean-layer rules](docs/city_ops_clean_layer_rules.md).
