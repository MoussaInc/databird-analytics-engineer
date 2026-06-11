select
   brand_id,
   brand_name
from {{ source('raw_data', 'brands') }}