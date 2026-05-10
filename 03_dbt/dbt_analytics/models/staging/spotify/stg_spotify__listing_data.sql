SELECT 
    song_id,
    cast(listen_date as date) as listen_date,
    coalesce(minutes_listened, 0) as minutes_listened
FROM {{ source('spotify', 'listing_data')}}
