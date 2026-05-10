WITH order_joined AS (
    SELECT
        o.customer_id,
        oi.order_id,
        oi.product_id,
        oi.quantity,
        oi.total_amount
    FROM {{ ref('stg_sales_database__order_item') }} oi
    LEFT JOIN {{ ref('stg_sales_database__orders') }} o 
        ON oi.order_id = o.order_id
),

user_detail as (
    select 
        customer_id,
        count(distinct order_id) as total_order,
        sum(total_amount) as total_amount
    from order_joined
    group by customer_id
),

nb_product_per_user as (
    select 
        customer_id,
        product_id,
        sum(quantity) as nb_product
    from order_joined
    group by customer_id, product_id
),

ranked as (
    select 
        customer_id,
        product_id,
        nb_product,
        row_number() over (partition by customer_id order by nb_product desc) as rn
    from nb_product_per_user
)

select 
    u.customer_id,
    u.customer_city,
    ud.total_order,
    ud.total_amount,
    rk.product_id,
    rk.nb_product
from {{ ref('stg_sales_database__user') }} u
left join user_detail ud on u.customer_id = ud.customer_id
left join ranked rk on ud.customer_id = rk.customer_id and rk.rn = 1