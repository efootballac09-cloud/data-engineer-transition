# Week 2 SQL Lab: Complaint Mix by Borough

## Scope

This analysis uses the bounded NYC 311 raw extract in `data/raw/nyc311_2024_q1.csv`.

- Rows analysed: 50,000
- Created-date coverage: 25–31 March 2024
- Output grain: one row per `borough × complaint_type`
- Source table: `raw_311`

Although the file name includes `q1`, this extract is a 50,000-row final-week-of-March sample. Results must not be interpreted as full-Q1 or citywide NYC 311 results.

## Question

Within each borough category, what share of requests belongs to each complaint type?

## Method

1. Grouped raw requests by `borough` and `complaint_type`.
2. Counted requests in each group as `request_count`.
3. Calculated `borough_total` with a window function partitioned by borough.
4. Calculated `complaint_share` as:

   `100.0 × request_count / borough_total`

5. Used `RANK()` to identify the leading complaint type(s) per borough. `RANK()` retains ties instead of arbitrarily selecting one record.

## Validation

- Row reconciliation passed: 50,000 raw rows = 50,000 summed grouped request counts.
- Denominator validation passed: complaint shares summed to 100.0% for every borough category.
- Week 1 data-quality baseline found zero blank borough values and zero blank complaint-type values. No rows were excluded from this analysis.
- `Unspecified` is retained as a source value and is not treated as a geographic borough.

## Leading Complaint Types

| Borough | Leading complaint type | Request count | Complaint share |
|---|---|---:|---:|
| BRONX | HEAT/HOT WATER | 1,579 | 16.19% |
| BROOKLYN | Illegal Parking | 3,034 | 19.77% |
| MANHATTAN | Illegal Parking | 1,212 | 11.46% |
| QUEENS | Illegal Parking | 2,768 | 22.11% |
| STATEN ISLAND | Illegal Parking | 284 | 16.05% |
| Unspecified | Municipal Parking Facility | 4 | 12.90% |
| Unspecified | Ferry Inquiry | 4 | 12.90% |

## Finding

In this 25–31 March 2024 sample, Heat/Hot Water was the largest complaint type in the Bronx. Illegal Parking led Brooklyn, Manhattan, Queens, and Staten Island. The `Unspecified` source category had a tie for first place between Municipal Parking Facility and Ferry Inquiry.

## Limitation

This is a bounded 50,000-row sample covering 25–31 March 2024 only. It cannot support quarter-wide, month-over-month, or overall NYC 311 claims. A complete or paginated Q1 extract would be required for those conclusions.

## Related SQL Evidence

- `01_sql/diagnostics/w2_complaint_mix_by_borough.sql`
- `01_sql/diagnostics/w2_complaint_mix_validation.sql`
- `01_sql/diagnostics/w2_complaint_share_validation.sql`
