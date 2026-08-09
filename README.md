# Data Engineer Transition

A hands-on six-month transition portfolio focused on modern Data Engineering.

## Target profile

Data Engineer with strong SQL, Python, Spark, data modelling, orchestration, testing, and analytics-engineering depth.

## Current phase

Week 2: SQL/Python foundation work and City Operations metric validation.

## Local setup

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements-dev.txt
python -m pytest

```

> **Setup verification:** A fresh-terminal run completed successfully with Python 3.12, the smoke test passing, and the bounded 50,000-row extract loading into DuckDB.

## Week 1 evidence

- [Week 1 baseline findings](docs/week1_baseline_findings.md)
- [Baseline SQL](01_sql/diagnostics/w1_baseline.sql)
- [Invalid closure investigation](01_sql/diagnostics/w1_invalid_closure_records.sql)
- [Clean-layer rules](docs/city_ops_clean_layer_rules.md)
- [NYC 311 load script](scripts/load_311.py)
- [Smoke test](tests/test_smoke.py)

## Week 2 SQL evidence

- [Complaint mix by borough](01_sql/diagnostics/w2_complaint_mix_by_borough.sql)
- [Grouped-count reconciliation](01_sql/diagnostics/w2_complaint_mix_validation.sql)
- [Complaint-share validation](01_sql/diagnostics/w2_complaint_share_validation.sql)
- [Leading complaint types by borough](01_sql/diagnostics/w2_top_complaint_by_borough.sql)
- [Complaint-mix findings](docs/week2_complaint_mix_findings.md)

## Dataset scope

The intended scope was Q1 2024, but the current 50,000-row extract covers only 25–31 March 2024 because of the extraction limit. Results describe this bounded sample and must not be presented as quarter-wide or month-over-month findings.

The sample contains 708 requests without a closure timestamp and 15 records where closure precedes creation. These records remain in the raw data and are handled using the documented [clean-layer rules](docs/city_ops_clean_layer_rules.md).
