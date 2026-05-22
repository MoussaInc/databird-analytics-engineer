select
    o.order_id,
    case
        when o.order_status = 1 then 'Pending' 
        when o.order_status = 2 then 'Processing' 
        when o.order_status = 3 then 'Rejected' 
        when o.order_status = 4 then 'Completed' 
        when o.order_status = 5 then 'Refunded' 
        else 'Unknown_status' 
    end as order_status,
    o.order_at,
    o.required_at,
    o.shipped_at,

    -- customer
    o.customer_id,
    c.full_name as customer_name,
    c.city as customer_city,
    c.state as customer_state,

    -- store
    o.store_id,
    st.store_name,
    st.city as store_city,
    st.state as store_state,

    -- staff
    o.staff_id,
    sf.full_name as staff_name,

    -- calculs délais
    datediff('day', o.order_at, o.shipped_at) as delivery_delay_days,
    datediff('day', o.order_at, o.required_at) as expected_delay_days,
    case
        when o.shipped_at <= o.required_at then true
        else false
    end as is_on_time

from {{ ref('stg_orders') }} o
left join {{ ref('stg_customers') }} c on o.customer_id = c.customer_id
left join {{ ref('stg_stores') }} st on o.store_id = st.store_id
left join {{ ref('stg_staffs') }} sf on o.staff_id = sf.staff_id