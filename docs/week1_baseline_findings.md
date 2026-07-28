# Week 1 Baseline Findings
| Finding | Result | Meaning |

| Total rows | 50,000 | Expected from the download limit |
| Date range | Mar 25–31, 2024 | This is not a full Jan–Mar Q1 extract |
| Blank borough | 0 | No technically blank borough values |
| Blank complaint type | 0 | No technically blank complaint types |
| Missing closed date | 708 | About 1.42% of requests are still open or have no closure timestamp |
| Invalid dates | 15 | Closure happened before creation; exclude these from duration metrics |
| Missing unique key | 0 | Every record has an ID |
| Duplicate keys / rows | 0 / 0 | No duplicate IDs in this extract |

## Dataset scope
Scope should be Q1 but data seems to be of march 2024 last week only as per the date range we got.
## Data-quality findings
1.unique_key behaves as a candidate business key in this extract: it has no nulls and no duplicates in the current sample.
2.The 708 missing closed_date values are not automatically bad data. They may represent requests that are still open. They should be excluded from closure-duration calculations, but retained in the raw data.
## Impact on analysis
The extract is incomplete for Q1, likely because the API response was capped at 50,000 rows. The current file covers only Mar 25–31, so it cannot support quarter-wide or month-over-month analysis.
## Next action
Inspect the 15 invalid-date records and create a validity flag in the clean layer; do not delete raw records. Replace the one-request 50,000-row download with a paginated or month-by-month extraction that covers the intended Q1 period.


## Invalid date investigation

All 15 invalid records belong to the DOT agency and the Street Light Condition complaint type. They occur across Brooklyn, Bronx, Queens, and Staten Island.

The calculated closure durations are consistently about negative one day. This pattern is consistent with a systematic timestamp or source-process issue, but the exact root cause cannot be proven from this extract alone.

### Handling decision

Retain these records in the raw layer. Add a validity flag in the clean layer, exclude invalid records from closure-duration metrics, and keep their count visible as a data-quality measure.