select
    count(order_id) as order_count,
    store_id,
    order_status
from orders
group by store_id, order_status

select
    store_id,
    count(case when order_status = 'pending' then order_id end) as pending_count,
    count(case when order_status = 'shipped' then order_id end) as shipped_count,
    count(case when order_status = 'delivered' then order_id end) as delivered_count,
    count(case when order_status = 'cancelled' then order_id end) as cancelled_count
from orders
group by store_id

select 
    *
from orders
    pivot(count(order_id) for order_status in ('pending', 'shipped', 'delivered', 'cancelled'))
        as p(store_id, pending_count, shipped_count, delivered_count, cancelled_count)


select
    order_id, 
    store_id, 
    order_status,
    order_date, 
    shipped_date,
    datediff(shipped_date, order_date, day) as shipping_duration,
    avg(datediff(shipped_date, order_date, day)) over (partition by store_id) as avg_shipping_duration
from orders
where order_status = 'delivered'

select 
    oi.*
from order_items as oi
left join orders as o on oi.order_id = o.order_id
where o.order_id is null