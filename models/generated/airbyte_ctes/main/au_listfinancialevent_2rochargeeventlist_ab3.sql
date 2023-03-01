{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2rochargeeventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        object_to_string('basetax'),
        'posteddate',
        object_to_string('shippingtax'),
        'amazonorderid',
        'marketplacename',
        'retrochargeeventtype',
        array_to_string('retrochargetaxwithheldlist'),
    ]) }} as _airbyte_retrochargeeventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2rochargeeventlist_ab2') }} tmp
-- retrochargeeventlist at AU_ListFinancialEvents/RetrochargeEventList
where 1 = 1

