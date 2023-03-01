{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2ervicingeventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(loanamount as {{ type_json() }}) as loanamount,
    cast(sourcebusinesseventtype as {{ dbt_utils.type_string() }}(1024)) as sourcebusinesseventtype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2ervicingeventlist_ab1') }}
-- loanservicingeventlist at AU_ListFinancialEvents/LoanServicingEventList
where 1 = 1

