{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2spaymenteventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(taxvalue as {{ type_json() }}) as taxvalue,
    cast(basevalue as {{ type_json() }}) as basevalue,
    cast(invoiceid as {{ dbt_utils.type_string() }}(1024)) as invoiceid,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    cast(transactiontype as {{ dbt_utils.type_string() }}(1024)) as transactiontype,
    cast(transactionvalue as {{ type_json() }}) as transactionvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2spaymenteventlist_ab1') }}
-- productadspaymenteventlist at AU_ListFinancialEvents/ProductAdsPaymentEventList
where 1 = 1

