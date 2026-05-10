WITH seller_revenue AS (
    SELECT 
        seller_id,
        SUM(total_amount) AS total_revenue
    FROM {{ ref('stg_sales_database__order_item') }}
    GROUP BY seller_id
)

,seller_orders AS (
    SELECT DISTINCT
        oi.seller_id,
        oi.order_id
    FROM {{ ref('stg_sales_database__order_item') }} oi
)

,seller_feedback AS (
    SELECT
        so.seller_id,
        AVG(f.feedback_score) AS avg_feedback_seller
    FROM seller_orders so
    LEFT JOIN {{ ref('stg_sales_database__feedback') }} f 
        ON so.order_id = f.order_id
    GROUP BY so.seller_id
)

SELECT
    sr.seller_id,
    sr.total_revenue,
    sf.avg_feedback_seller

FROM seller_revenue sr
LEFT JOIN seller_feedback sf 
    ON sr.seller_id = sf.seller_id