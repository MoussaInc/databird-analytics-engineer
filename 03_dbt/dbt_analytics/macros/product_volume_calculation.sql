{% macro product_volume_calculation(width, length, hight) %}

({{ width }} * {{ length }} * {{ hight }})

{% endmacro %}