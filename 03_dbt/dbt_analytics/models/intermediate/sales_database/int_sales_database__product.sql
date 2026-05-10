WITH product_detail AS (
    SELECT 
        oi.product_id,
        oi.quantity,
        u.customer_id,
        u.customer_state
    FROM {{ ref('stg_sales_database__order_item') }} oi
    LEFT JOIN {{ ref('stg_sales_database__orders') }} o 
        ON oi.order_id = o.order_id
    LEFT JOIN {{ ref('stg_sales_database__user') }} u 
        ON o.customer_id = u.customer_id
),

nb_customer_per_product AS (
    SELECT
        product_id,
        COUNT(DISTINCT customer_id) AS total_customer
    FROM product_detail
    GROUP BY product_id
),

region_per_product AS (
    SELECT
        product_id,
        customer_state,
        COUNT(DISTINCT customer_id) AS nb_customer
    FROM product_detail
    GROUP BY product_id, customer_state
),

ranked_region AS (
    SELECT
        product_id,
        customer_state,
        nb_customer,
        RANK() OVER (PARTITION BY product_id ORDER BY nb_customer DESC) AS rn
    FROM region_per_product
)

SELECT 
    p.product_id,
    p.product_category,
    {{ product_volume_calculation('p.product_width_cm', 'p.product_length_cm' , 'p.product_height_cm') }} AS volume_cm3,
    nc.total_customer,
    rr.customer_state AS dominant_region
FROM {{ ref('stg_sales_database__product') }} p
LEFT JOIN nb_customer_per_product nc 
    ON p.product_id = nc.product_id
LEFT JOIN ranked_region rr 
    ON p.product_id = rr.product_id
    AND rr.rn = 1