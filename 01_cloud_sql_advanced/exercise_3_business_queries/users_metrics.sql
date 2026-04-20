WITH orders_per_user AS (
    SELECT
        o.user_name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.price * oi.quantity + oi.shipping_cost) AS total_spent
    FROM `order_items` AS oi
    LEFT JOIN orders AS o ON oi.order_id = o.order_id
    GROUP BY o.user_name
),

favorite_product AS (
    SELECT
        o.user_name,
        oi.product_id,
        SUM(oi.quantity) AS total_quantity,
        ROW_NUMBER() OVER (PARTITION BY o.user_name ORDER BY total_quantity DESC) AS rank
    FROM order_items AS oi
    LEFT JOIN orders AS o ON oi.order_id = o.order_id
    GROUP BY o.user_name, oi.product_id
)

SELECT
    u.user_name,
    u.customer_city,
    COALESCE(opu.total_orders, 0) AS total_orders,
    COALESCE(opu.total_spent, 0) AS total_spent,    
    fp.product_id AS favorite_product_id,
    fp.total_quantity AS favorite_product_quantity  
FROM users AS u 
LEFT JOIN orders_per_user AS opu ON u.user_name = opu.user_name
LEFT JOIN favorite_product AS fp ON u.user_name = fp.user_name AND fp.rank = 1;