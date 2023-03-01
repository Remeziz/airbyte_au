{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_orders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('isispu'),
        boolean_to_string('isprime'),
        'ordertype',
        'seller_id',
        boolean_to_string('issoldbyab'),
        object_to_string('ordertotal'),
        'orderstatus',
        'purchasedate',
        'saleschannel',
        'amazonorderid',
        'marketplaceid',
        'paymentmethod',
        'sellerorderid',
        boolean_to_string('ispremiumorder'),
        'lastupdatedate',
        'latestshipdate',
        boolean_to_string('isbusinessorder'),
        'earliestshipdate',
        'shipservicelevel',
        'fulfillmentchannel',
        'isreplacementorder',
        'numberofitemsshipped',
        array_to_string('paymentmethoddetails'),
        boolean_to_string('isglobalexpressenabled'),
        'numberofitemsunshipped',
        'shipmentservicelevelcategory',
    ]) }} as _airbyte_au_orders_hashid,
    tmp.*
from {{ ref('au_orders_ab2') }} tmp
-- au_orders
where 1 = 1

