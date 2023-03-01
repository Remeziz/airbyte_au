{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2argebackeventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'posteddate',
        array_to_string('orderfeelist'),
        'amazonorderid',
        'sellerorderid',
        'marketplacename',
        array_to_string('orderchargelist'),
        array_to_string('shipmentfeelist'),
        array_to_string('shipmentitemlist'),
        array_to_string('directpaymentlist'),
        array_to_string('orderfeeadjustmentlist'),
        array_to_string('orderchargeadjustmentlist'),
        array_to_string('shipmentfeeadjustmentlist'),
        array_to_string('shipmentitemadjustmentlist'),
    ]) }} as _airbyte_chargebackeventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2argebackeventlist_ab2') }} tmp
-- chargebackeventlist at AU_ListFinancialEvents/ChargebackEventList
where 1 = 1

