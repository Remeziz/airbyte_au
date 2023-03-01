{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_get_sales_and_traf_2eport_salesbyasin_ab1') }}
select
    _airbyte_au_get_sales__traffic_report_hashid,
    cast(unitsordered as {{ dbt_utils.type_float() }}) as unitsordered,
    cast(totalorderitems as {{ dbt_utils.type_float() }}) as totalorderitems,
    cast(orderedproductsales as {{ type_json() }}) as orderedproductsales,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_get_sales_and_traf_2eport_salesbyasin_ab1') }}
-- salesbyasin at AU_GET_SALES_AND_TRAFFIC_REPORT/salesByAsin
where 1 = 1

