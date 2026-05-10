select
    minutes_listened
from {{ ref('stg_spotify__listing_data') }}
where minutes_listened <= 0 or minutes_listened is null