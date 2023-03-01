{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('main', '_airbyte_raw_au_get_sales_and_traffic_report') }}
select
    {{ json_extract_scalar('_airbyte_data', ['childAsin'], ['childAsin']) }} as childasin,
    {{ json_extract_scalar('_airbyte_data', ['parentAsin'], ['parentAsin']) }} as parentasin,
    {{ json_extract('table_alias', '_airbyte_data', ['salesByAsin'], ['salesByAsin']) }} as salesbyasin,
    {{ json_extract_scalar('_airbyte_data', ['queryEndDate'], ['queryEndDate']) }} as queryenddate,
    {{ json_extract('table_alias', '_airbyte_data', ['trafficByAsin'], ['trafficByAsin']) }} as trafficbyasin,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('main', '_airbyte_raw_au_get_sales_and_traffic_report') }} as table_alias
-- au_get_sales_and_traffic_report
where 1 = 1

