{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2nsactioneventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'asin',
        object_to_string('taxamount'),
        'posteddate',
        'swapreason',
        'marketplaceid',
        'transactiontype',
        'netcotransactionid',
        object_to_string('taxexclusiveamount'),
    ]) }} as _airbyte_networkcommi__ctioneventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2nsactioneventlist_ab2') }} tmp
-- networkcomminglingtransactioneventlist at AU_ListFinancialEvents/NetworkComminglingTransactionEventList
where 1 = 1

