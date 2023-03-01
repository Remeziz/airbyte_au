{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2recoveryeventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(recoveryamount as {{ type_json() }}) as recoveryamount,
    cast(debtrecoverytype as {{ dbt_utils.type_string() }}(1024)) as debtrecoverytype,
    cast(overpaymentcredit as {{ type_json() }}) as overpaymentcredit,
    chargeinstrumentlist,
    debtrecoveryitemlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2recoveryeventlist_ab1') }}
-- debtrecoveryeventlist at AU_ListFinancialEvents/DebtRecoveryEventList
where 1 = 1

