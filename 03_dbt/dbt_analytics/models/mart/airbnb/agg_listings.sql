{{ 
    config(
        materialized='table',
       tags=['daily', 'airbnb', 'reporting']
    )
}}

select
    neighbourhood_cleansed, 
    room_type, 
    avg(unit_price) as avg_listing_price,
    count(listing_id) as total_listings
from {{ ref('stg_airbnb__listings') }}
group by neighbourhood_cleansed, room_type