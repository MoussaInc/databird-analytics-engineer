
SELECT
  DATE_TRUNC(o.order_created_at, MONTH) AS order_month,
  COUNT(DISTINCT o.customer_id) AS total_monthly_users,
  COUNT(DISTINCT IF(u.customer_state LIKE '%JAWA%TIMUR%', o.customer_id, NULL)) AS total_monthly_users_from_jawa_timur,
  COUNT(o.order_id) AS total_monthly_orders
FROM {{ ref("stg_sales_database__orders") }} AS o
LEFT JOIN {{ ref("stg_sales_database__user") }} AS u
  ON u.customer_id  = o.customer_id
GROUP BY order_month
ORDER BY order_month