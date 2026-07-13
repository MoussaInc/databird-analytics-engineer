{{
    config(
        materialized='incremental',
        unique_key='order_item_id',
        incremental_strategy='merge',
        cluster_by=['date_id', 'store_id']
    )
}}

select
    -- clés
    oi.order_item_id,
    oi.order_id,
    oi.item_id,

    -- foreign keys vers dimensions
    oi.product_id,
    oi.category_id,
    oi.brand_id,
    o.customer_id,
    o.store_id,
    o.staff_id,
    cast(o.order_at as date) as date_id,

    -- statut commande
    o.order_status,
    o.order_at,
    o.shipped_at,
    o.required_at,

    -- métriques produit
    oi.quantity,
    oi.price,
    oi.discount,
    oi.unit_price_net,
    oi.revenue_gross,
    oi.revenue_net,
    oi.discount_amount,

    -- métriques livraison
    o.delivery_delay_days,
    o.expected_delay_days,
    o.is_on_time

from {{ ref('int_order_items_enriched') }} oi
left join {{ ref('int_orders_enriched') }} o on oi.order_id = o.order_id

{% if is_incremental() %}
where o.order_at >= (
    select 
        coalesce(max(order_at), '1900-01-01'::timestamp)
    from {{ this }}
)
{% endif %}