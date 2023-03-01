{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_orders') }}
select
    _airbyte_au_orders_hashid,
    {{ json_extract_scalar('ordertotal', ['Amount'], ['Amount']) }} as amount,
    {{ json_extract_scalar('ordertotal', ['CurrencyCode'], ['CurrencyCode']) }} as currencycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_orders') }} as table_alias
-- ordertotal at AU_Orders/OrderTotal
where 1 = 1
and ordertotal is not null

