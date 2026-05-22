
select
    p.product_id,
    p.product_name,
    p.model_year,
    p.price,
    c.category_id,
    c.category_name,
    b.brand_id,
    b.brand_name
from {{ ref('stg_products') }} p
left join {{ ref('stg_categories') }} c on p.category_id = c.category_id
left join {{ ref('stg_brands') }} b on p.brand_id = b.brand_id