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
complaint_mix as (
    select
        borough,
        complaint_type,
        request_count,
        100.0 * request_count
            / sum(request_count) over (partition by borough)
            as complaint_share
    from complaint_counts
)

select
    borough,
    round(sum(complaint_share), 10) as borough_share_total_pct
from complaint_mix
group by borough
order by borough;
