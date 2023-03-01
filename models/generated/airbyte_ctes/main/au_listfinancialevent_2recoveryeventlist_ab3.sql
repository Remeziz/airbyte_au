{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2recoveryeventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        object_to_string('recoveryamount'),
        'debtrecoverytype',
        object_to_string('overpaymentcredit'),
        array_to_string('chargeinstrumentlist'),
        array_to_string('debtrecoveryitemlist'),
    ]) }} as _airbyte_debtrecoveryeventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2recoveryeventlist_ab2') }} tmp
-- debtrecoveryeventlist at AU_ListFinancialEvents/DebtRecoveryEventList
where 1 = 1

