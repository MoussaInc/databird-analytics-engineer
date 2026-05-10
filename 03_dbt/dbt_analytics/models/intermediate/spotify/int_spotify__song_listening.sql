with max_date as (
  select 
  date_add(max(listen_date), INTERVAL -2 year) as min_date
  from {{ ref('stg_spotify__listing_data') }}
)

select
    s.song_id,
    s.title,
    s.artist,
    s.album,
    s.release_year,
    s.genre,
    l.listen_date,
    l.minutes_listened
from {{ ref('stg_spotify__listing_data') }} l
join max_date md on l.listen_date >= md.min_date
join {{ ref('stg_spotify__songs') }} s on l.song_id = s.song_id
order by l.listen_date desc