{{ config(
    materialized = 'table'
) }}

select
    cast(id as string) as id,
    cast(host_id as string) as host_id,
    cast(neighbourhood_cleansed as string) as neighbourhood_cleansed,
    cast(room_type as string) as room_type,
    cast(coalesce(price, 0) as numeric) as price,
    cast(minimum_nights as integer) as minimum_nights,
    cast(number_of_reviews as integer) as number_of_reviews,
    cast(availability_365 as integer) as availability_365
from {{ source('airbnb', 'listings') }}