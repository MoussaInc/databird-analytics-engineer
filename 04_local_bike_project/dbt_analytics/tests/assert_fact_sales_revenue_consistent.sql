
-- Vérifie que revenue_net <= revenue_gross (discount ne peut pas augmenter le prix)
select 
    order_item_id
from {{ ref('fact_sales') }}
where revenue_net > revenue_gross