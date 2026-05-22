
-- Vérifie que les quantités sont toujours > 0
select 
    order_item_id
from {{ ref('fact_sales') }}
where quantity <= 0