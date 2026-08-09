with complaint_counts as (
    select
        borough,
        complaint_type,
        count(*) as request_count
    from raw_311
    group by
        borough,
        complaint_type
)

select
    borough,
    complaint_type,
    request_count,
    sum(request_count) over (
        partition by borough
    ) as borough_total,
    round(
        100.0 * request_count
        / sum(request_count) over (partition by borough),
        2
    ) as complaint_share
from complaint_counts
order by
    borough,
    request_count desc;
