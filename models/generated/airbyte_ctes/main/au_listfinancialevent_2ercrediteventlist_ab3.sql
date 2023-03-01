{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2ercrediteventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'sellerid',
        'providerid',
        'marketplaceid',
        'sellerorderid',
        'sellerstorename',
        'providerstorename',
        object_to_string('transactionamount'),
        'marketplacecountrycode',
        'providertransactiontype',
        'transactioncreationdate',
    ]) }} as _airbyte_serviceprovi__rediteventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2ercrediteventlist_ab2') }} tmp
-- serviceprovidercrediteventlist at AU_ListFinancialEvents/ServiceProviderCreditEventList
where 1 = 1

