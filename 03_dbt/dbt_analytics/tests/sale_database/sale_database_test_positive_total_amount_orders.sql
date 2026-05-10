select
 total_amount
from {{ ref('stg_sales_database__order_item') }}
where total_amount < 0