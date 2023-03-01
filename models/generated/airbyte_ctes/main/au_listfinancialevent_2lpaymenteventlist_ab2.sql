{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2lpaymenteventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(dealid as {{ dbt_utils.type_string() }}(1024)) as dealid,
    cast(feetype as {{ dbt_utils.type_string() }}(1024)) as feetype,
    cast(eventtype as {{ dbt_utils.type_string() }}(1024)) as eventtype,
    cast(feeamount as {{ type_json() }}) as feeamount,
    cast(taxamount as {{ type_json() }}) as taxamount,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    cast(totalamount as {{ type_json() }}) as totalamount,
    cast(dealdescription as {{ dbt_utils.type_string() }}(1024)) as dealdescription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2lpaymenteventlist_ab1') }}
-- sellerdealpaymenteventlist at AU_ListFinancialEvents/SellerDealPaymentEventList
where 1 = 1

