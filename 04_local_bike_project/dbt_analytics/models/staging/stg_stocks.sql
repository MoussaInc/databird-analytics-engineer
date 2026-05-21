select
    product_id,
    store_id,
    cast(quantity as integer) as quantity
from {{ source('raw_data', 'stocks') }}