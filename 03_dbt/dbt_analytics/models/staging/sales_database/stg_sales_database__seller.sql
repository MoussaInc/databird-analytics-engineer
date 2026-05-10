select
    seller_id,
    seller_city,
    seller_state,	
    seller_zip_code
from {{ source('sales_database', 'seller') }}