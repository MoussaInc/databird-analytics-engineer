{% docs int_sales_database__order %}

This model provides an aggregated view of customer orders by combining data from multiple sources such as orders, order items, feedback, and customer information.
The model is built at the order level and contains important business metrics used for reporting and analytics.

Main metrics included in this model:
- **Total Order Amount**: The total amount paid for all items in the order.
- **Total Items**: The total quantity of items included in the order.
- **Total Distinct Items**: The number of different products purchased in the order.
- **Average Feedback Score**: The average review score given by customers for the order.
- **Customer State**: The state where the customer is located.
- **Order Status**: The current status of the order (approved, delivered, canceled, etc.).

This model is mainly used as an intermediate layer before building marts and business dashboards.

{% enddocs %}