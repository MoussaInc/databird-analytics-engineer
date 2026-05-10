{% docs int_sales_database__user %}

This model provides a user or customer-level summary by combining user, order, and order item data.
The model helps analyze customer purchasing behavior and identify the most purchased product for each customer.

Main metrics included in this model:
- **Total Orders**: The total number of distinct orders made by the customer.
- **Total Amount**: The total amount spent by the customer across all orders.
- **Most Purchased Product**: The product most frequently purchased by the customer.
- **Number of Products Purchased**: The total quantity purchased for the most purchased product.
- **Customer City**: The city where the customer is located.

This model is mainly used for customer analytics, segmentation, and reporting.

{% enddocs %}