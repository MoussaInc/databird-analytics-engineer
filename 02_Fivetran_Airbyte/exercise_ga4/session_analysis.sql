
WITH aggregated_session_data AS (
  SELECT
    user_pseudo_id,
    ga_session_id,

    MIN(TIMESTAMP_MICROS(event_timestamp)) AS session_start_time,
    MAX(TIMESTAMP_MICROS(event_timestamp)) AS session_end_time,

    MAX(browser) AS browser_used,
    MAX(medium) AS traffic_medium,
    MAX(source) AS traffic_source,
    MAX(name) AS traffic_name,

    COUNT(*) AS event_count,
    COUNTIF(event_name = 'page_view') AS pages_viewed

  FROM `databird-formation-493320.google_analytics_4.events_flattened`
  GROUP BY user_pseudo_id, ga_session_id
)

SELECT 
  user_pseudo_id,
  ga_session_id,
  CONCAT(user_pseudo_id, '-', ga_session_id) AS unique_session_id,

  session_start_time,
  session_end_time,

  TIMESTAMP_DIFF(session_end_time, session_start_time, SECOND) AS session_duration_seconds,

  browser_used,
  traffic_medium,
  traffic_source,
  traffic_name,

  event_count,
  pages_viewed

FROM aggregated_session_data
ORDER BY session_duration_seconds DESC;

