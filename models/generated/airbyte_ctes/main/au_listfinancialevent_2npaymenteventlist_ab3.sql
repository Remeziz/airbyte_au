{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2npaymenteventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'couponid',
        'posteddate',
        object_to_string('totalamount'),
        object_to_string('feecomponent'),
        'paymenteventid',
        object_to_string('chargecomponent'),
        'cliporredemptioncount',
        'sellercoupondescription',
    ]) }} as _airbyte_couponpaymenteventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2npaymenteventlist_ab2') }} tmp
-- couponpaymenteventlist at AU_ListFinancialEvents/CouponPaymentEventList
where 1 = 1

