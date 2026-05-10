select
    concat(order_id, '-', product_id, '-', seller_id, '-', cast(pickup_limit_date as string)) as order_item_id,
    order_id,
    product_id,	
    seller_id,
    pickup_limit_date as pickup_limit_at,
    coalesce(quantity, 0) as quantity,
    coalesce(price, 0) as unit_price,
    coalesce(shipping_cost, 0) as shipping_cost,
    coalesce((quantity * price +  shipping_cost), 0) as total_amount
from {{ source('sales_database', 'order_item') }}