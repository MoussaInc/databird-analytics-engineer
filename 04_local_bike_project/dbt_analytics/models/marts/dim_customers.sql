
select
    customer_id,
    full_name,
    email,
    phone,
    street,
    city,
    state,
    zip_code
from {{ ref('stg_customers') }}