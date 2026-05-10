select
    product_id,
    product_category,
    product_weight_g,
    product_width_cm,
    product_length_cm,
    product_height_cm,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty
from {{ source('sales_database', 'product') }}