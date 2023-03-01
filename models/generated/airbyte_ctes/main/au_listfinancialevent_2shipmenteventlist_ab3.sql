{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2shipmenteventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'orderid',
        'posteddate',
        'merchantorderid',
        'transactiontype',
        array_to_string('removalshipmentitemlist'),
    ]) }} as _airbyte_removalshipmenteventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2shipmenteventlist_ab2') }} tmp
-- removalshipmenteventlist at AU_ListFinancialEvents/RemovalShipmentEventList
where 1 = 1

