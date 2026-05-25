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
    cast(zip_code as int) as zip_code
from {{ source('raw_data', 'customers') }}