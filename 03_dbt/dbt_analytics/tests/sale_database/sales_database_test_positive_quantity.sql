select 
    quantity
from {{ ref('stg_sales_database__order_item') }}
where quantity <= 0