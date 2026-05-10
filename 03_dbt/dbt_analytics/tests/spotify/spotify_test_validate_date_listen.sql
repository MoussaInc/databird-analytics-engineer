-- date d'écoute incorrecte

select 
    listen_date
from {{ ref('stg_spotify__listing_data') }}
where listen_date > current_date