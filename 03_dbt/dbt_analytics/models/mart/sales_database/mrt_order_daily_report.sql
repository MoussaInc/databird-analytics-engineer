select
    -- dimensions
    orders.order_created_at,
    mapping.account_manager,
    mapping.state,

    -- métriques
    count(orders.order_id) as nb_orders,
    avg(orders.total_item) as avg_items_per_order,
    avg(orders.avg_feedback_score) as avg_feedback_score_per_order,
    avg(orders.total_amount) as avg_total_amount_per_order

from {{ ref('int_sales_database__order') }} orders
left join {{ ref('stg_gs__account_manager_region_mapping') }} mapping
on orders.customer_state = mapping.state
group by     
    orders.order_created_at,
    mapping.account_manager,
    mapping.state