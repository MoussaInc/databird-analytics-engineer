select 
    customer_id,
    first_name,
    last_name,
    concat(first_name, ' ', last_name) as full_name,
    email,
    phone,
    street,
    city,
    state,
    zip_code
from {{ source('raw_data', 'customers') }}