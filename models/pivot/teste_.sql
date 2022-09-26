
select * from (
    select 
        o.O_ORDERSTATUS, o.O_TOTALPRICE, o.O_ORDERDATE 
    from {{ source('sample', 'ORDERS') }} o    
    {# union
    select
        'A' as O_ORDERSTATUS,
        99.99 as O_TOTALPRICE,
        '1992-01-01' as O_ORDERDATE #}
        
    ) t order by O_ORDERSTATUS, O_ORDERDATE 
PIVOT (
    sum(O_TOTALPRICE)
    for O_ORDERSTATUS in (
        'P', 'F', 'O'
    )
)
as p (Data, Partiu, Ficou, Outros)

{{ this.database }}
{{ this.schema }}

{%- set tab = adapter.get_relation(
      database='SNOWFLAKE_SAMPLE_DATA',
      schema='TPCH_SF10',
      identifier='orders') -%}

{{ tab }}