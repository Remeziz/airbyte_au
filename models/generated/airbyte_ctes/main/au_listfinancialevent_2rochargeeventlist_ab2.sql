{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2rochargeeventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(basetax as {{ type_json() }}) as basetax,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    cast(shippingtax as {{ type_json() }}) as shippingtax,
    cast(amazonorderid as {{ dbt_utils.type_string() }}(1024)) as amazonorderid,
    cast(marketplacename as {{ dbt_utils.type_string() }}(1024)) as marketplacename,
    cast(retrochargeeventtype as {{ dbt_utils.type_string() }}(1024)) as retrochargeeventtype,
    retrochargetaxwithheldlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2rochargeeventlist_ab1') }}
-- retrochargeeventlist at AU_ListFinancialEvents/RetrochargeEventList
where 1 = 1

