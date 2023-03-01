{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2ursementeventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    cast(reasoncode as {{ dbt_utils.type_string() }}(1024)) as reasoncode,
    cast(safetclaimid as {{ dbt_utils.type_string() }}(1024)) as safetclaimid,
    cast(reimbursedamount as {{ type_json() }}) as reimbursedamount,
    safetreimbursementitemlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2ursementeventlist_ab1') }}
-- safetreimbursementeventlist at AU_ListFinancialEvents/SAFETReimbursementEventList
where 1 = 1

