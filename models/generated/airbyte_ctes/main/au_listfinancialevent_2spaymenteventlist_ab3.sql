{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2spaymenteventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        object_to_string('taxvalue'),
        object_to_string('basevalue'),
        'invoiceid',
        'posteddate',
        'transactiontype',
        object_to_string('transactionvalue'),
    ]) }} as _airbyte_productadspaymenteventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2spaymenteventlist_ab2') }} tmp
-- productadspaymenteventlist at AU_ListFinancialEvents/ProductAdsPaymentEventList
where 1 = 1

