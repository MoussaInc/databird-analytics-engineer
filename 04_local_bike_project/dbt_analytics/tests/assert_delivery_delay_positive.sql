
-- Vérifie que le délai de livraison est positif (shipped_at >= order_at)
select 
    order_id
from {{ ref('int_orders_enriched') }}
where delivery_delay_days < 0