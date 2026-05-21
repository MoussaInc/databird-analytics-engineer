select 
    order_id,
    customer_id,
    staff_id,
    store_id,
    order_date as order_at,
    order_status,
    required_date as required_at,
    shipped_date as shipped_at
from {{ source('raw_data', 'orders') }}