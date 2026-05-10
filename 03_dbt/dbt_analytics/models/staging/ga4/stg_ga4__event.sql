with events_20210131_data as (
  select
    PARSE_DATE('%Y%m%d', event_date) as event_date,
    TIMESTAMP_MICROS(event_timestamp) as event_timestamp,
    event_name,
    user_pseudo_id,
    user_first_touch_timestamp,
    device.web_info.browser as browser,
    traffic_source.medium as traffic_medium,
    traffic_source.source as traffic_source,
    traffic_source.name as campaign_name,
    event_params
  from {{ source('ga4', 'events_20210131') }}
)

select
  event_date,
  event_timestamp,
  event_name,
  user_pseudo_id,
  user_first_touch_timestamp,
  browser,
  traffic_medium,
  traffic_source,
  campaign_name,
  MAX(IF(ep.key = 'ga_session_id', ep.value.int_value, NULL)) as ga_session_id,
  MAX(IF(ep.key = 'page_title', ep.value.string_value, NULL)) as page_title,
  MAX(IF(ep.key = 'page_location', ep.value.string_value, NULL)) as page_location
from events_20210131_data
left join UNNEST(event_params) as ep
group by event_date,
  event_timestamp,
  event_name,
  user_pseudo_id,
  user_first_touch_timestamp,
  browser,
  traffic_medium,
  traffic_source,
  campaign_name
