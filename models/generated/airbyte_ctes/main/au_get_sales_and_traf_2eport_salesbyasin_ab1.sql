{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_get_sales_and_traffic_report') }}
select
    _airbyte_au_get_sales__traffic_report_hashid,
    {{ json_extract_scalar('salesbyasin', ['unitsOrdered'], ['unitsOrdered']) }} as unitsordered,
    {{ json_extract_scalar('salesbyasin', ['totalOrderItems'], ['totalOrderItems']) }} as totalorderitems,
    {{ json_extract('table_alias', 'salesbyasin', ['orderedProductSales'], ['orderedProductSales']) }} as orderedproductsales,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_get_sales_and_traffic_report') }} as table_alias
-- salesbyasin at AU_GET_SALES_AND_TRAFFIC_REPORT/salesByAsin
where 1 = 1
and salesbyasin is not null

