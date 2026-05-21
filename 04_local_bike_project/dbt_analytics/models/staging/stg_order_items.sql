select
    {{ dbt_utils.generate_surrogate_key(['order_id', 'item_id', 'product_id']) }} AS order_item_id,
    order_id,
    item_id,
    product_id,
    cast(quantity as integer) as quantity,
    cast(list_price as decimal(10,2)) as price, 
    cast(discount as decimal(10,2)) as discount
from {{ source('raw_data', 'order_items') }}