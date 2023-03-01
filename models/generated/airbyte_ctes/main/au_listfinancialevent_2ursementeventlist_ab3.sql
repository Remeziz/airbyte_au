{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2ursementeventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'posteddate',
        'reasoncode',
        'safetclaimid',
        object_to_string('reimbursedamount'),
        array_to_string('safetreimbursementitemlist'),
    ]) }} as _airbyte_safetreimbursementeventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2ursementeventlist_ab2') }} tmp
-- safetreimbursementeventlist at AU_ListFinancialEvents/SAFETReimbursementEventList
where 1 = 1

