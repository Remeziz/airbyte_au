{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2teeclaimeventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    orderfeelist,
    cast(amazonorderid as {{ dbt_utils.type_string() }}(1024)) as amazonorderid,
    cast(sellerorderid as {{ dbt_utils.type_string() }}(1024)) as sellerorderid,
    cast(marketplacename as {{ dbt_utils.type_string() }}(1024)) as marketplacename,
    orderchargelist,
    shipmentfeelist,
    shipmentitemlist,
    directpaymentlist,
    orderfeeadjustmentlist,
    orderchargeadjustmentlist,
    shipmentfeeadjustmentlist,
    shipmentitemadjustmentlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2teeclaimeventlist_ab1') }}
-- guaranteeclaimeventlist at AU_ListFinancialEvents/GuaranteeClaimEventList
where 1 = 1

