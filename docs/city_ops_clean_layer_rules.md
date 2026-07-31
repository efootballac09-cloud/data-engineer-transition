# City Operations clean-layer rules

## Purpose
This clean layer supports City Operations decision-making by providing reliable request-volume, request-status, and closure-duration metrics by borough and complaint type.

## Grain
One row in `stg_311_requests` represents one NYC 311 service request.

The business key is `unique_key`. Borough, complaint type, and status are descriptive attributes, not part of the key.

## Open requests
When `closed_date` is null, I will retain the record and set `is_open_request` to true.

When a request is open, `due_date` is not null, and `due_date` is before the documented `as_of_timestamp`, I will set `is_overdue_open_request` to true.

Open requests will not be included in closure-duration metrics because they have no completed timestamp, so their closure duration is unknown.

## Invalid durations
A closure duration is invalid when `closed_date < created_date`.

I will retain the raw record and set `is_valid_closure_duration` to false.

For closure-duration reporting, invalid records will have `closure_duration_minutes` set to null and will be excluded from completed-duration metrics. Their count will remain visible as a data-quality measure.

## Duplicates
I will detect duplicates with `COUNT(*) > 1` grouped by `unique_key`.

Raw data will retain every received record.

The clean layer will keep one record per `unique_key`, selecting the latest non-null `resolution_action_updated_date`, then `closed_date`, then `created_date`. If records remain tied after those fields, the duplicate test will fail and the records require investigation before publishing metrics.

## Other handling rules
Missing `created_date`: retain the record, set `is_missing_created_date` to true, and exclude it from date-based and closure-duration metrics.

Missing borough or `complaint_type`: standardise blank strings to null and set `is_missing_borough` or `is_missing_complaint_type` to true. Use an `Unknown` display label only in a downstream reporting model, not in the clean layer.

## Validation plan
1. Test that `unique_key` is not null and unique in the clean model.
2. Confirm the clean model has 708 open requests and 15 invalid closure-date records in this sample.
3. Confirm `closure_duration_minutes` is null for open or invalid records and non-negative for valid completed records.
4. Confirm the clean model has 50,000 rows in this current sample because the baseline found no duplicates.

## Definition of done
This task is done only when these grain, handling, flags, exclusions, duplicate, and validation rules are saved in `docs/city_ops_clean_layer_rules.md` and reviewed.