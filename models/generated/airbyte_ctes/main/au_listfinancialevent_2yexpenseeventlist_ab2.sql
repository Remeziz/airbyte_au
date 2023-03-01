{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2yexpenseeventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    cast(baseexpense as {{ type_json() }}) as baseexpense,
    cast(taxtypecgst as {{ type_json() }}) as taxtypecgst,
    cast(taxtypeigst as {{ type_json() }}) as taxtypeigst,
    cast(taxtypesgst as {{ type_json() }}) as taxtypesgst,
    cast(totalexpense as {{ type_json() }}) as totalexpense,
    cast(amazonorderid as {{ dbt_utils.type_string() }}(1024)) as amazonorderid,
    cast(marketplaceid as {{ dbt_utils.type_string() }}(1024)) as marketplaceid,
    cast(transactiontype as {{ dbt_utils.type_string() }}(1024)) as transactiontype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2yexpenseeventlist_ab1') }}
-- affordabilityexpenseeventlist at AU_ListFinancialEvents/AffordabilityExpenseEventList
where 1 = 1

