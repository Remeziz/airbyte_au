{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_get_sales_and_traf_3deredproductsales_ab1') }}
select
    _airbyte_salesbyasin_hashid,
    cast(amount as {{ dbt_utils.type_float() }}) as amount,
    cast(currencycode as {{ dbt_utils.type_string() }}(1024)) as currencycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_get_sales_and_traf_3deredproductsales_ab1') }}
-- orderedproductsales at AU_GET_SALES_AND_TRAFFIC_REPORT/salesByAsin/orderedProductSales
where 1 = 1

