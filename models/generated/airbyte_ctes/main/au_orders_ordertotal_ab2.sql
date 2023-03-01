{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_orders_ordertotal_ab1') }}
select
    _airbyte_au_orders_hashid,
    cast(amount as {{ dbt_utils.type_string() }}(1024)) as amount,
    cast(currencycode as {{ dbt_utils.type_string() }}(1024)) as currencycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_orders_ordertotal_ab1') }}
-- ordertotal at AU_Orders/OrderTotal
where 1 = 1

