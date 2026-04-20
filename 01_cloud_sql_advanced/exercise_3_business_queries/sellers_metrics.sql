WITH seller_detail AS (
    SELECT
        seller_id,
        SUM(oi.quantity * oi.price + oi.shipping_cost) AS total_revenue
    FROM order_items
    GROUP BY seller_id
),

avg_feedback_per_seller AS (
    SELECT
        seller_id,
        AVG(feedback_score) AS avg_feedback_score
    FROM feedback AS f
    INNER JOIN orders AS o ON f.order_id = o.order_id
    INNER JOIN order_items AS oi ON o.order_id = oi.order_id
    GROUP BY seller_id
)

SELECT
    sd.seller_id,
    COALESCE(sd.total_revenue, 0.00) AS total_revenue,
    afps.avg_feedback_score
FROM seller_detail AS sd
LEFT JOIN avg_feedback_per_seller AS afps ON sd.seller_id = afps.seller_id
ORDER BY sd.total_revenue DESC;