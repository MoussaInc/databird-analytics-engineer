select
    product_id,
    product_name,
    category_id,
    brand_id,
    list_price as price,
    model_year
from {{ source('raw_data', 'products') }}