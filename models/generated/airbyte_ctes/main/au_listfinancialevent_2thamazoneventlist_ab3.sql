{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2thamazoneventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        object_to_string('charge'),
        array_to_string('feelist'),
        'storename',
        'saleschannel',
        'sellerorderid',
        'amountdescription',
        'paymentamounttype',
        'businessobjecttype',
        'fulfillmentchannel',
        'transactionposteddate',
    ]) }} as _airbyte_paywithamazoneventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2thamazoneventlist_ab2') }} tmp
-- paywithamazoneventlist at AU_ListFinancialEvents/PayWithAmazonEventList
where 1 = 1

