select
    concat(cast(order_id as string), '-', cast(payment_sequential as string)) as payment_id,
    order_id,
    payment_type,
    payment_sequential,
    payment_value,
    payment_installments
from {{ source('sales_database', 'payment')}}