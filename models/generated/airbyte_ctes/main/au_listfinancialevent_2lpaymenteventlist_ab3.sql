{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2lpaymenteventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'dealid',
        'feetype',
        'eventtype',
        object_to_string('feeamount'),
        object_to_string('taxamount'),
        'posteddate',
        object_to_string('totalamount'),
        'dealdescription',
    ]) }} as _airbyte_sellerdealpaymenteventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2lpaymenteventlist_ab2') }} tmp
-- sellerdealpaymenteventlist at AU_ListFinancialEvents/SellerDealPaymentEventList
where 1 = 1

