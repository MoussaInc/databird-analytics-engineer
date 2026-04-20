# E-commerce Performance Analysis (SQL)

## Objective

Analyze an e-commerce dataset to extract key business insights across orders, customers, products, and sellers.

---

## Key Analyses

### Orders
- Total order value
- Number of items
- Average customer feedback

### Customers
- Total spending (LTV)
- Number of orders
- Favorite product

### Products
- Number of buyers
- Dominant region
- Sales volume

### Sellers
- Total revenue
- Average feedback score

---

## Approach

- Modular SQL using CTEs
- Clean aggregations
- Window functions for ranking (ROW_NUMBER)
- NULL handling (COALESCE)

---

## Files

- `orders_metrics.sql`
- `users_metrics.sql`
- `products_metrics.sql`
- `sellers_metrics.sql`

---

## Key Insight

This project demonstrates how raw transactional data can be transformed into actionable business insights using SQL.