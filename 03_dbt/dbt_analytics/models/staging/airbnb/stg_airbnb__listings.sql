select
    id as listing_id,
    host_id, 
    neighbourhood_cleansed, 
    room_type, 
    coalesce(price, 0) as unit_price,
    minimum_nights, 
    number_of_reviews, 
    availability_365
from {{ source('airbnb', 'listings') }}