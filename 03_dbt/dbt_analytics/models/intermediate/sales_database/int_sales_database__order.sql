with order_detail as (
    select 
        order_id,
        sum(total_amount) as total_amount,
        sum(quantity) as total_item,
        count(distinct product_id) as total_distinct_item
    from {{ ref('stg_sales_database__order_item') }}
group by order_id
)
, avg_score as (
    select 
        order_id,
        avg(feedback_score) as avg_feedback_score
    from {{ ref('stg_sales_database__feedback') }}
    group by order_id
)

select  
    o.order_id,
    o.order_status,
    o.order_created_at,
    o.order_approved_at,
    od.total_amount,
    od.total_item,
    od.total_distinct_item,
    round(sc.avg_feedback_score, 2) as avg_feedback_score,
    u.customer_state
from {{ ref('stg_sales_database__orders') }} as o
left join order_detail as od on o.order_id = od.order_id
left join avg_score as sc on od.order_id = sc.order_id
left join {{ ref('stg_sales_database__user') }} u on o.customer_id = u.customer_id
