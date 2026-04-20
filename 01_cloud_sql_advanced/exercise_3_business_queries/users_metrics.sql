WITH orders_per_user AS (
    SELECT
        user_name,
        COUNT(order_id) AS total_orders,
        SUM(oi.price * oi.quantity + oi.shipping_cost) AS total_order_value
    FROM `order_items` AS oi
    LEFT JOIN orders AS o ON oi.order_id = o.order_id
    GROUP BY user_name
),
favorite_product AS (
    SELECT
        o.user_name,
        oi.product_id,
        SUM(oi.quantity) AS total_quantity
        ROW_NUMBER() OVER (PARTITION BY oi.product_id ORDER BY total_quantity DESC) AS rank
    FROM order_items AS oi
    LEFT JOIN orders AS o ON oi.order_id = o.order_id
    GROUP BY user_name, product_id
)
SELECT
    user_name,
    customer_city,
    total_orders,
    total_order_value,
    fp.product_id AS favorite_product_id,
    fp.total_quantity AS favorite_product_quantity  
FROM users AS u 
LEFT JOIN orders_per_user AS opu ON u.user_name = opu.user_name
LEFT JOIN favorite_product AS fp ON u.user_name = fp.user_name AND fp.rank = 1;