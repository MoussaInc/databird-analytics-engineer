
-- plus de 10h d'écoute parrait suspect
select
    minutes_listened
from {{ ref('stg_spotify__listing_data') }}
where minutes_listened > 600