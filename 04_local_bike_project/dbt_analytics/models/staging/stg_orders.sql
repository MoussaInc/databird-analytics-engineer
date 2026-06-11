select 
    order_id,
    customer_id,
    staff_id,
    store_id,
    try_cast(order_date as date) as order_at,
    order_status,
    try_cast(required_date as date) as required_at,
    try_cast(shipped_date as date) as shipped_at
from {{ source('raw_data', 'orders') }}