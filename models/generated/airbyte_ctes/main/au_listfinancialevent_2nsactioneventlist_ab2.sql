{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2nsactioneventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(asin as {{ dbt_utils.type_string() }}(1024)) as asin,
    cast(taxamount as {{ type_json() }}) as taxamount,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    cast(swapreason as {{ dbt_utils.type_string() }}(1024)) as swapreason,
    cast(marketplaceid as {{ dbt_utils.type_string() }}(1024)) as marketplaceid,
    cast(transactiontype as {{ dbt_utils.type_string() }}(1024)) as transactiontype,
    cast(netcotransactionid as {{ dbt_utils.type_string() }}(1024)) as netcotransactionid,
    cast(taxexclusiveamount as {{ type_json() }}) as taxexclusiveamount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2nsactioneventlist_ab1') }}
-- networkcomminglingtransactioneventlist at AU_ListFinancialEvents/NetworkComminglingTransactionEventList
where 1 = 1

