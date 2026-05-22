
-- dbt_utils.date_spine = macro qui génère une liste de dates consécutives 
with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2015-12-31' as date)",
        end_date="cast('2019-12-31' as date)"
    ) }}
)

select
    cast(date_day as date) as date_id,
    date_day as full_date,
    year(date_day) as year,
    month(date_day) as month,
    day(date_day) as day,
    quarter(date_day) as quarter,
    dayofweek(date_day) as day_of_week,
    dayname(date_day) as day_name,
    monthname(date_day) as month_name,
    case
        when dayofweek(date_day) in (1, 7) then true
        else false
    end as is_weekend

from date_spine