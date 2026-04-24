CREATE OR REPLACE TABLE `databird-formation-493320.google_analytics_4.events` AS (
SELECT *
FROM bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131
);

SELECT
  *
FROM `databird-formation-493320.google_analytics_4.events`
LIMIT 5;

CREATE OR REPLACE TABLE `databird-formation-493320.google_analytics_4.events_flattened` AS (
SELECT 
  event_date,
  event_timestamp,
  event_name,
  -- ga_session_id
  (SELECT value.int_value    #param data type
  FROM UNNEST(event_params)  #unnest the events
  WHERE key = 'ga_session_id' ) AS ga_session_id,
  
  -- page_title
  (SELECT value.string_value
  FROM UNNEST(event_params) 
  WHERE key = 'page_title') AS page_title,

  -- page_location
  (SELECT value.string_value
  FROM UNNEST(event_params) 
  WHERE key = 'page_location') AS page_location,
  user_pseudo_id,
  user_first_touch_timestamp,
  device.web_info.browser,
  traffic_source.medium,
  traffic_source.source,
  traffic_source.name

FROM `databird-formation-493320.google_analytics_4.events`
);