select 
    * 
from {{ source('raw_data', 'customers') }}