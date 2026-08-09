with complaint_counts as (
    select
        borough,
        complaint_type,
        count(*) as request_count
    from raw_311
    group by
        borough,
        complaint_type
),
source_total as (
    select count(*) as raw_row_count
    from raw_311
),
grouped_total as (
    select sum(request_count) as grouped_row_count
    from complaint_counts
)

select
    raw_row_count,
    grouped_row_count,
    raw_row_count - grouped_row_count as row_count_difference
from source_total
cross join grouped_total;
