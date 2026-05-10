select
    order_id,
    user_name as customer_id,
    order_date as order_created_at,
    order_approved_date as order_approved_at,
    pickup_date as pickup_at,
    delivered_date as delivered_at,
    order_status,
    estimated_time_delivery
from {{ source('sales_database', 'orders') }}
