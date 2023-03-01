{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2ercrediteventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(sellerid as {{ dbt_utils.type_string() }}(1024)) as sellerid,
    cast(providerid as {{ dbt_utils.type_string() }}(1024)) as providerid,
    cast(marketplaceid as {{ dbt_utils.type_string() }}(1024)) as marketplaceid,
    cast(sellerorderid as {{ dbt_utils.type_string() }}(1024)) as sellerorderid,
    cast(sellerstorename as {{ dbt_utils.type_string() }}(1024)) as sellerstorename,
    cast(providerstorename as {{ dbt_utils.type_string() }}(1024)) as providerstorename,
    cast(transactionamount as {{ type_json() }}) as transactionamount,
    cast(marketplacecountrycode as {{ dbt_utils.type_string() }}(1024)) as marketplacecountrycode,
    cast(providertransactiontype as {{ dbt_utils.type_string() }}(1024)) as providertransactiontype,
    cast({{ empty_string_to_null('transactioncreationdate') }} as {{ type_timestamp_with_timezone() }}) as transactioncreationdate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2ercrediteventlist_ab1') }}
-- serviceprovidercrediteventlist at AU_ListFinancialEvents/ServiceProviderCreditEventList
where 1 = 1

