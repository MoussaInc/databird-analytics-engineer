WITH product_summary AS (
    SELECT
        oi.product_id,
        u.customer_city,
        COUNT(DISTINCT u.user_name) AS total_customers
    FROM order_items AS oi
    LEFT JOIN orders AS o ON oi.order_id = o.order_id
    LEFT JOIN users AS u ON o.user_name = u.user_name
    GROUP BY product_id, u.customer_city
),

dominant_customers AS (
    SELECT
        product_id,
        customer_city,
        total_customers,
        ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY total_customers DESC) AS rank
    FROM product_summary
)

SELECT
    p.product_id,
    p.product_category,
    (p.product_length_cm * p.product_width_cm * p.product_height_cm) AS product_volume_cm3,
    dc.customer_city AS dominant_customer_city,
    dc.total_customers AS dominant_customer_count
FROM product AS p 
LEFT JOIN dominant_customers AS dc ON p.product_id = dc.product_id AND dc.rank = 1;
