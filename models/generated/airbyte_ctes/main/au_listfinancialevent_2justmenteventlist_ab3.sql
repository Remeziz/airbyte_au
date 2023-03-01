{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2justmenteventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'orderid',
        'posteddate',
        'merchantorderid',
        'transactiontype',
        'adjustmenteventid',
        array_to_string('removalshipmentitemadjustmentlist'),
    ]) }} as _airbyte_removalshipm__tmenteventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2justmenteventlist_ab2') }} tmp
-- removalshipmentadjustmenteventlist at AU_ListFinancialEvents/RemovalShipmentAdjustmentEventList
where 1 = 1

