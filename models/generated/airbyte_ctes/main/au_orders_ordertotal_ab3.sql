{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_orders_ordertotal_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_orders_hashid',
        'amount',
        'currencycode',
    ]) }} as _airbyte_ordertotal_hashid,
    tmp.*
from {{ ref('au_orders_ordertotal_ab2') }} tmp
-- ordertotal at AU_Orders/OrderTotal
where 1 = 1

