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
),
ranked_complaints as (
    select
        borough,
        complaint_type,
        request_count,
        complaint_share,
        rank() over (
            partition by borough
            order by request_count desc
        ) as complaint_rank
    from complaint_mix
)

select
    borough,
    complaint_type,
    request_count,
    round(complaint_share, 2) as complaint_share
from ranked_complaints
where complaint_rank = 1
order by borough;
