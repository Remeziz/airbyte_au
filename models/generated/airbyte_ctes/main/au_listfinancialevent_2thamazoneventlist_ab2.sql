{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2thamazoneventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(charge as {{ type_json() }}) as charge,
    feelist,
    cast(storename as {{ dbt_utils.type_string() }}(1024)) as storename,
    cast(saleschannel as {{ dbt_utils.type_string() }}(1024)) as saleschannel,
    cast(sellerorderid as {{ dbt_utils.type_string() }}(1024)) as sellerorderid,
    cast(amountdescription as {{ dbt_utils.type_string() }}(1024)) as amountdescription,
    cast(paymentamounttype as {{ dbt_utils.type_string() }}(1024)) as paymentamounttype,
    cast(businessobjecttype as {{ dbt_utils.type_string() }}(1024)) as businessobjecttype,
    cast(fulfillmentchannel as {{ dbt_utils.type_string() }}(1024)) as fulfillmentchannel,
    cast({{ empty_string_to_null('transactionposteddate') }} as {{ type_timestamp_with_timezone() }}) as transactionposteddate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2thamazoneventlist_ab1') }}
-- paywithamazoneventlist at AU_ListFinancialEvents/PayWithAmazonEventList
where 1 = 1

