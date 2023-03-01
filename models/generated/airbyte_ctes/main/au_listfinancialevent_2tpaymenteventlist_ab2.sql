{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2tpaymenteventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(parentasin as {{ dbt_utils.type_string() }}(1024)) as parentasin,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    cast(totalamount as {{ type_json() }}) as totalamount,
    cast(enrollmentid as {{ dbt_utils.type_string() }}(1024)) as enrollmentid,
    cast(feecomponent as {{ type_json() }}) as feecomponent,
    cast(chargecomponent as {{ type_json() }}) as chargecomponent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2tpaymenteventlist_ab1') }}
-- sellerreviewenrollmentpaymenteventlist at AU_ListFinancialEvents/SellerReviewEnrollmentPaymentEventList
where 1 = 1

