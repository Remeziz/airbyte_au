{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2tpaymenteventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'parentasin',
        'posteddate',
        object_to_string('totalamount'),
        'enrollmentid',
        object_to_string('feecomponent'),
        object_to_string('chargecomponent'),
    ]) }} as _airbyte_sellerreview__ymenteventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2tpaymenteventlist_ab2') }} tmp
-- sellerreviewenrollmentpaymenteventlist at AU_ListFinancialEvents/SellerReviewEnrollmentPaymentEventList
where 1 = 1

