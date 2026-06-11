select
    oi.order_item_id,
    oi.order_id,
    oi.item_id,
    oi.product_id,
    p.product_name,
    c.category_id,
    c.category_name,
    b.brand_id,
    b.brand_name,
    oi.quantity,
    oi.price,
    oi.discount,

    -- calculs revenus
    round(oi.price * (1 - oi.discount), 2) as unit_price_net,
    round(oi.quantity * oi.price, 2) as revenue_gross,
    round(oi.quantity * oi.price * (1 - oi.discount), 2) as revenue_net,
    round(oi.quantity * oi.price * oi.discount, 2) as discount_amount

from {{ ref('stg_order_items') }} oi
left join {{ ref('stg_products') }} p on oi.product_id = p.product_id
left join {{ ref('stg_categories') }} c on p.category_id = c.category_id
left join {{ ref('stg_brands') }} b on p.brand_id = b.brand_id