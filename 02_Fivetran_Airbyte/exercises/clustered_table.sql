CREATE OR REPLACE TABLE `databird-formation-493320.google_analytics_4.events_flattened_clustered` 
CLUSTER BY event_name AS (
SELECT 
  *
FROM `databird-formation-493320.google_analytics_4.events_flattened`
);
