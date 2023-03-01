{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_orders_ab1') }}
select
    {{ cast_to_boolean('isispu') }} as isispu,
    {{ cast_to_boolean('isprime') }} as isprime,
    cast(ordertype as {{ dbt_utils.type_string() }}(1024)) as ordertype,
    cast(seller_id as {{ dbt_utils.type_string() }}(1024)) as seller_id,
    {{ cast_to_boolean('issoldbyab') }} as issoldbyab,
    cast(ordertotal as {{ type_json() }}) as ordertotal,
    cast(orderstatus as {{ dbt_utils.type_string() }}(1024)) as orderstatus,
    cast(purchasedate as {{ dbt_utils.type_string() }}(1024)) as purchasedate,
    cast(saleschannel as {{ dbt_utils.type_string() }}(1024)) as saleschannel,
    cast(amazonorderid as {{ dbt_utils.type_string() }}(1024)) as amazonorderid,
    cast(marketplaceid as {{ dbt_utils.type_string() }}(1024)) as marketplaceid,
    cast(paymentmethod as {{ dbt_utils.type_string() }}(1024)) as paymentmethod,
    cast(sellerorderid as {{ dbt_utils.type_string() }}(1024)) as sellerorderid,
    {{ cast_to_boolean('ispremiumorder') }} as ispremiumorder,
    cast(lastupdatedate as {{ dbt_utils.type_string() }}(1024)) as lastupdatedate,
    cast(latestshipdate as {{ dbt_utils.type_string() }}(1024)) as latestshipdate,
    {{ cast_to_boolean('isbusinessorder') }} as isbusinessorder,
    cast(earliestshipdate as {{ dbt_utils.type_string() }}(1024)) as earliestshipdate,
    cast(shipservicelevel as {{ dbt_utils.type_string() }}(1024)) as shipservicelevel,
    cast(fulfillmentchannel as {{ dbt_utils.type_string() }}(1024)) as fulfillmentchannel,
    cast(isreplacementorder as {{ dbt_utils.type_string() }}(1024)) as isreplacementorder,
    cast(numberofitemsshipped as {{ dbt_utils.type_bigint() }}) as numberofitemsshipped,
    paymentmethoddetails,
    {{ cast_to_boolean('isglobalexpressenabled') }} as isglobalexpressenabled,
    cast(numberofitemsunshipped as {{ dbt_utils.type_bigint() }}) as numberofitemsunshipped,
    cast(shipmentservicelevelcategory as {{ dbt_utils.type_string() }}(1024)) as shipmentservicelevelcategory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_orders_ab1') }}
-- au_orders
where 1 = 1

