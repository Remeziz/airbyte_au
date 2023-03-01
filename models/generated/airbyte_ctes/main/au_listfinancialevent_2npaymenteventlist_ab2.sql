{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2npaymenteventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(couponid as {{ dbt_utils.type_string() }}(1024)) as couponid,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    cast(totalamount as {{ type_json() }}) as totalamount,
    cast(feecomponent as {{ type_json() }}) as feecomponent,
    cast(paymenteventid as {{ dbt_utils.type_string() }}(1024)) as paymenteventid,
    cast(chargecomponent as {{ type_json() }}) as chargecomponent,
    cast(cliporredemptioncount as {{ dbt_utils.type_bigint() }}) as cliporredemptioncount,
    cast(sellercoupondescription as {{ dbt_utils.type_string() }}(1024)) as sellercoupondescription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2npaymenteventlist_ab1') }}
-- couponpaymenteventlist at AU_ListFinancialEvents/CouponPaymentEventList
where 1 = 1

