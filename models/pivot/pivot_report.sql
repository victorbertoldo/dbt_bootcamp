{% set query %}
    select distinct O_ORDERSTATUS from {{ source('sample', 'ORDERS') }}
    union
    select 'A' as O_ORDERSTATUS
{% endset %}

 {% set vals=[] %}

{% set results=run_query(query) %}

{%- if execute-%}

    {% set vals = results.columns[0].values() | list | sort %}
    
{%- endif -%}


select * from (
    select 
        'A' as O_ORDERSTATUS,
        99.99 as O_TOTALPRICE,
        '1992-01-01' as O_ORDERDATE
    union 
    select 
        o.O_ORDERSTATUS, o.O_TOTALPRICE, o.O_ORDERDATE 
    from {{ source('sample', 'ORDERS') }} o    
    order by O_ORDERSTATUS, O_ORDERDATE
        
    ) t  
PIVOT (
    sum(O_TOTALPRICE)
    for O_ORDERSTATUS in (
        {%- for i in vals -%}
            '{{ i }}'{%- if not loop.last %},{% endif %}
        {%- endfor -%}
    )
)
as p (Data, Aberto, Ficou, Outros, Partiu)

