select count(*) as Inavlid_records,
agency,
complaint_type,
borough , 
min(closure_duration_minutes) as minimum_closure_duration_minutes,
max(closure_duration_minutes) as maximum_closure_duration_minutes from
(
    select borough,agency,complaint_type,
    date_diff('minute',created_date,closed_date)as closure_duration_minutes from raw_311
    where closed_date<created_date and created_date is not NULL and closed_date is not null)as Temp
GROUP by agency,
complaint_type,
borough