
{% test accepted_status_values(model, column_name) %}

select *
from {{ model }}
where {{ column_name }} not in (
    {% for value in var('order_status_values') %}
        '{{ value }}'{% if not loop.last %},{% endif %}
    {% endfor %}
)

{% endtest %}