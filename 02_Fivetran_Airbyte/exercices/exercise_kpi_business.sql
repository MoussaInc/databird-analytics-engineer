SELECT 
    DATE_TRUNC('month', order_date) AS month,
    COUNT(DISTINCT user_id) AS nb_distinct_user,
    SUM(amount) AS total_revenue,
    SUM(amount)/ COUNT(order_id) AS avg_amount
FROM orders
GROUP BY month
ORDER BY month

-- calcul le cumul du chiffre d’affaires jour par jour
SELECT
    DATE_TRUNC('day', order_date) AS day,
    SUM(amount) AS daily_revenue,
    SUM(SUM(amount)) OVER ( 
        ORDER BY DATE_TRUNC('day', order_date) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_revenue
FROM orders
GROUP BY DATE_TRUNC('day', order_date)
ORDER BY day;

-- version equivalent:
WITH daily AS (
    SELECT
        DATE_TRUNC('day', order_date) AS day,
        SUM(amount) AS daily_revenue
    FROM orders
    GROUP BY day
)
SELECT
    day,
    daily_revenue,
    SUM(daily_revenue) OVER (ORDER BY day) AS cumulative_revenue
FROM daily
ORDER BY day;



-- Top 3 produits par catégorie
WITH product_by_category AS(
    SELECT
     p.product_id,
     p.category,
     SUM(oi.quantity * oi.price) AS total_revenue,
     RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity * oi.price) DESC) AS rank
    FROM products p
    INNER JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.category, p.product_id
)
SELECT
    product_id,
    category,
    total_revenue
FROM product_by_category
WHERE rank <= 3
ORDER BY category, total_revenue DESC;


-- Cohorte utilisateurs
WITH first_orders AS (
    SELECT
        user_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY user_id
)
SELECT
    DATE_TRUNC('month', f.first_order_date) AS cohort_month,
    DATE_DIFF(o.order_date, f.first_order_date, MONTH) AS months_since_first_order,
    COUNT(DISTINCT o.user_id) AS nb_users
FROM orders o
INNER JOIN first_orders f ON o.user_id = f.user_id
GROUP BY cohort_month, months_since_first_order
ORDER BY cohort_month, months_since_first_order;



-- Détection d’anomalies: Identifier les jours où le chiffre d’affaires est > 2 écarts-types au-dessus de la moyenne mobile (7 jours)
WITH daily_revenue AS (
    SELECT
        DATE(order_date) AS day,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY day
)
SELECT
    day,
    revenue,
    AVG(revenue) OVER (
        ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS avg_7d,
    STDDEV(revenue) OVER (
        ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS stddev_7d,
    CASE
        WHEN revenue > AVG(revenue) OVER (
            ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) + 2 * STDDEV(revenue) OVER (
            ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        )
        THEN 1 ELSE 0
    END AS is_anomaly
FROM daily_revenue
ORDER BY day;