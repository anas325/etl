select
    cast(date_format(d, '%Y%m%d') as unsigned)              as date_key,
    d                                                        as full_date,
    day(d)                                                   as day,
    month(d)                                                 as month,
    year(d)                                                  as year,
    quarter(d)                                               as quarter,
    dayname(d)                                               as day_name,
    monthname(d)                                             as month_name,
    week(d, 1)                                               as week_of_year,
    case when dayofweek(d) in (1, 7) then true else false end as is_weekend
from (
    select date('2020-01-01') + interval n day as d
    from (
        select a.n + b.n * 10 + c.n * 100 + d.n * 1000 as n
        from
            (select 0 n union all select 1 union all select 2 union all select 3 union all select 4
             union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) a
        cross join
            (select 0 n union all select 1 union all select 2 union all select 3 union all select 4
             union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) b
        cross join
            (select 0 n union all select 1 union all select 2 union all select 3 union all select 4
             union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) c
        cross join
            (select 0 n union all select 1 union all select 2 union all select 3 union all select 4
             union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) d
    ) numbers
    where n <= datediff('2030-12-31', '2020-01-01')
) dates
