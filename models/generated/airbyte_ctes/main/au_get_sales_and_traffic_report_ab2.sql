{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_get_sales_and_traffic_report_ab1') }}
select
    cast(childasin as {{ dbt_utils.type_string() }}(1024)) as childasin,
    cast(parentasin as {{ dbt_utils.type_string() }}(1024)) as parentasin,
    cast(salesbyasin as {{ type_json() }}) as salesbyasin,
    cast(queryenddate as {{ dbt_utils.type_string() }}(1024)) as queryenddate,
    cast(trafficbyasin as {{ type_json() }}) as trafficbyasin,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_get_sales_and_traffic_report_ab1') }}
-- au_get_sales_and_traffic_report
where 1 = 1

