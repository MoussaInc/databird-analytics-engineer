{% docs int_sales_database__product %}

This model provides a product-level summary by combining product, order item, order, and customer data.
The model is used to analyze product performance, customer distribution, and the most active region for each product.

Main metrics and information included in this model:
- **Product Category**: Category of the product.
- **Product Volume**: Calculated product volume in cubic centimeters using width, length, and height.
- **Total Customers**: Number of distinct customers who purchased the product.
- **Dominant Region**: The state with the highest number of customers for the product.

This model is mainly used for product analytics, sales analysis, and customer behavior reporting.

{% enddocs %}