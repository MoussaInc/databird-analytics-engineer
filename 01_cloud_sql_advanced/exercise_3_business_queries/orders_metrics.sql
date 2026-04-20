WITH order_summary AS (
    SELECT
        order_id,
        SUM(quantity) AS total_items,
        COUNT(DISTINCT product_id) AS total_distinct_items,
        SUM(quantity * price + shipping_cost) AS total_order_value
    FROM `order_items`
    GROUP BY order_id
),
avg_feedback AS (
    SELECT
        order_id,
        ROUND(AVG(feedback_score), 2) AS avg_feedback_score
    FROM feedback
    GROUP BY order_id
)

SELECT 
    -- Dimensions
    o.order_id,
    o.status,
    o.order_date AS order_created_at,
    o.order_approved AS order_approved_at,

    -- metrics
    COALESCE(os.total_items, 0) AS total_items,
    COALESCE(os.total_distinct_items, 0) AS total_distinct_items,
    COALESCE(os.total_order_value, 0) AS total_order_value,
    COALESCE(af.avg_feedback_score, 0) AS avg_feedback_score
    FROM orders AS o
    LEFT JOIN order_summary AS os ON o.order_id = os.order_id
    LEFT JOIN avg_feedback AS af ON o.order_id = af.order_id;