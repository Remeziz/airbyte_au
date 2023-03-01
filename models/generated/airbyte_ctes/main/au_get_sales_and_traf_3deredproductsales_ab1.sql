{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_get_sales_and_traffic_report_salesbyasin') }}
select
    _airbyte_salesbyasin_hashid,
    {{ json_extract_scalar('orderedproductsales', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('orderedproductsales', ['currencyCode'], ['currencyCode']) }} as currencycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_get_sales_and_traffic_report_salesbyasin') }} as table_alias
-- orderedproductsales at AU_GET_SALES_AND_TRAFFIC_REPORT/salesByAsin/orderedProductSales
where 1 = 1
and orderedproductsales is not null

