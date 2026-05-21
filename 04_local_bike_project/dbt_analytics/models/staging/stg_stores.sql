select 
    store_id,
    store_name,
    email,
    phone,
    street,
    city,
    state,
    zip_code
from {{ source('raw_data', 'stores') }}