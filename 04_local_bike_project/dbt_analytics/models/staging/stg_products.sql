select
    product_id,
    product_name,
    category_id,
    brand_id,
    cast(list_price as number(10,2)) as price,
    cast(model_year as int) as model_year
from {{ source('raw_data', 'products') }}