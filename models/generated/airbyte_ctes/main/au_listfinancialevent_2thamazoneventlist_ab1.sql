{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'paywithamazoneventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract('', unnested_column_value('paywithamazoneventlist'), ['Charge'], ['Charge']) }} as charge,
    {{ json_extract_array(unnested_column_value('paywithamazoneventlist'), ['FeeList'], ['FeeList']) }} as feelist,
    {{ json_extract_scalar(unnested_column_value('paywithamazoneventlist'), ['StoreName'], ['StoreName']) }} as storename,
    {{ json_extract_scalar(unnested_column_value('paywithamazoneventlist'), ['SalesChannel'], ['SalesChannel']) }} as saleschannel,
    {{ json_extract_scalar(unnested_column_value('paywithamazoneventlist'), ['SellerOrderId'], ['SellerOrderId']) }} as sellerorderid,
    {{ json_extract_scalar(unnested_column_value('paywithamazoneventlist'), ['AmountDescription'], ['AmountDescription']) }} as amountdescription,
    {{ json_extract_scalar(unnested_column_value('paywithamazoneventlist'), ['PaymentAmountType'], ['PaymentAmountType']) }} as paymentamounttype,
    {{ json_extract_scalar(unnested_column_value('paywithamazoneventlist'), ['BusinessObjectType'], ['BusinessObjectType']) }} as businessobjecttype,
    {{ json_extract_scalar(unnested_column_value('paywithamazoneventlist'), ['FulfillmentChannel'], ['FulfillmentChannel']) }} as fulfillmentchannel,
    {{ json_extract_scalar(unnested_column_value('paywithamazoneventlist'), ['TransactionPostedDate'], ['TransactionPostedDate']) }} as transactionposteddate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- paywithamazoneventlist at AU_ListFinancialEvents/PayWithAmazonEventList
{{ cross_join_unnest('au_listfinancialevents', 'paywithamazoneventlist') }}
where 1 = 1
and paywithamazoneventlist is not null

