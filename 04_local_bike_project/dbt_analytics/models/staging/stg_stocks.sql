select
    product_id,
    store_id,
    cast(quantity as int) as quantity
from {{ source('raw_data', 'stocks') }}