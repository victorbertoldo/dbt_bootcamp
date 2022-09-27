{# {%- set columns = adapter.get_columns_in_relation(ref('dim_hosts_cleansed')) -%}

{%-  for column in columns %}
    {{ column }} {{ column.is_string() }}
{% endfor %} #}