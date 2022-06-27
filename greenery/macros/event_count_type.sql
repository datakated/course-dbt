{% macro event_count_type() %}
  {% set event_types = [
    "add_to_cart"
    , "checkout"
    , "package_shipped"
    , "page_view" 
  ]%}
  {% for event_type in event_types %}
    COUNT(CASE WHEN event_type = '{{ event_type }}' THEN event_type ELSE null END) AS {{ event_type }}_count,
  {% endfor %}
{% endmacro %}