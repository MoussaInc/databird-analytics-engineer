select 
    store_id,
    store_name,
    email,
    phone,
    street,
    city,
    state,
    cast(zip_code as int) as zip_code
from {{ source('raw_data', 'stores') }}