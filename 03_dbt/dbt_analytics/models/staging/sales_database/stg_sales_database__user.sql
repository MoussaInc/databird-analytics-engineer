select
    user_name as customer_id,
    customer_city,	
    customer_state,	
    customer_zip_code,	
    row_num as customer_row_num
from {{ source('sales_database', 'user') }}