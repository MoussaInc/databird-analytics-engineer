-- Q1: CA mensuel + nb clients uniques
SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.order_amount) AS total_revenue,
    COUNT(DISTINCT o.user_id) AS unique_customers
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
GROUP BY month

-- Q2: nb client qui ont cmmade au moins 2 mois
WITH customer_months AS (
    SELECT
        COUNT(DISTINCT o.user_id) AS unique_customers,
        DATE_TRUNC('month', order_date) AS month
    FROM orders
    GROUP BY month
),
ranked AS (
    SELECT
        month,
        unique_customers,
        RANK() OVER (PARTITION BY month ORDER BY month) AS month_rank
    FROM customer_months
)
SELECT
    month,
    unique_customers
FROM ranked WHERE month_rank >= 2
ORDER BY month;



-- Q3: Top 3 par CA sur les 6 deniers mois
WITH recent_orders AS (
    SELECT
        o.order_id,
        o.order_date,
        o.amount,
        u.user_id
    FROM orders o
    INNER JOIN users u ON o.user_id = u.user_id
    WHERE o.order_date >= DATEADD(month, -6, CURRENT_DATE)
),
ranked_products AS (
    SELECT
        oi.product_id,
        SUM(oi.quantity * oi.price) AS total_revenue,
        RANK() OVER (ORDER BY SUM(oi.quantity * oi.price) DESC) AS revenue_rank
    FROM recent_orders ro
    INNER JOIN order_items oi ON ro.order_id = oi.order_id
    GROUP BY oi.product_id
)
SELECT
    product_id,
    total_revenue
FROM ranked_products
WHERE revenue_rank <= 3
ORDER BY total_revenue DESC;    