{# {% set query %}
    select 
    *
    from AIRBNB.DEV.FCT_REVIEWS
    limit 10
{% endset %}

{% set results=run_query(query) %}
{%- if execute-%}
    {{ results.pivot(key='REVIEW_DATE', pivot='REVIEW_SENTIMENT') }}

{%- endif -%}     #}