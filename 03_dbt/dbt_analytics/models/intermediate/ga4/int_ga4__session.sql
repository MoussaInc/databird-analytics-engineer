{{ 
    config(
        materialized='table',
        cluster_by=['page_title', 'event_name']
    ) 
}}

with aggregate_session_level as (
    select
        ga_session_id,
        user_pseudo_id,
        event_date,
        event_name,
        page_title,
        page_location,
        min(event_timestamp) as session_start_time,
        max(event_timestamp) as session_end_time,
        timestamp_diff(max(event_timestamp), min(event_timestamp), second) as session_duration_seconds,
        sum(case when event_name = 'page_view' then 1 else 0 end) as pages_viewed,
        count(*) as event_count,
        any_value(user_first_touch_timestamp) as user_first_touch_timestamp,
        any_value(browser) as browser_used,
        any_value(traffic_medium) as traffic_medium,
        any_value(traffic_source) as traffic_source,
        any_value(campaign_name) as campaign_name
    from {{ ref('stg_ga4__event') }}
    group by ga_session_id, user_pseudo_id, event_date, event_name, page_title, page_location
)

select
    concat(user_pseudo_id, '-', ga_session_id) as unique_session_id,
    user_pseudo_id,
    ga_session_id,
    event_date,
    event_name,
    page_title,
    page_location,
    session_duration_seconds,
    session_start_time,
    session_end_time,
    pages_viewed,
    event_count,
    browser_used,
    traffic_medium,
    traffic_source,
    campaign_name
from aggregate_session_level
where session_duration_seconds >= 30