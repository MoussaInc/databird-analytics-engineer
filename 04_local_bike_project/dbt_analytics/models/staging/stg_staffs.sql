select
    staff_id,
    store_id,
    manager_id,
    first_name,
    last_name,
    concat(first_name, ' ', last_name) as full_name,
    email,
    phone,
    active
from {{ source('raw_data', 'staffs') }}