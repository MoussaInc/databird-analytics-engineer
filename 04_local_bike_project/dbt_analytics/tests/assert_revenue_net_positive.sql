
-- Vérifie que le revenue net est toujours positif
select 
    order_item_id
from {{ ref('int_order_items_enriched') }}
where revenue_net < 0