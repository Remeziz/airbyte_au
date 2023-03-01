{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'refundeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('refundeventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract_array(unnested_column_value('refundeventlist'), ['OrderFeeList'], ['OrderFeeList']) }} as orderfeelist,
    {{ json_extract_scalar(unnested_column_value('refundeventlist'), ['AmazonOrderId'], ['AmazonOrderId']) }} as amazonorderid,
    {{ json_extract_scalar(unnested_column_value('refundeventlist'), ['SellerOrderId'], ['SellerOrderId']) }} as sellerorderid,
    {{ json_extract_scalar(unnested_column_value('refundeventlist'), ['MarketplaceName'], ['MarketplaceName']) }} as marketplacename,
    {{ json_extract_array(unnested_column_value('refundeventlist'), ['OrderChargeList'], ['OrderChargeList']) }} as orderchargelist,
    {{ json_extract_array(unnested_column_value('refundeventlist'), ['ShipmentFeeList'], ['ShipmentFeeList']) }} as shipmentfeelist,
    {{ json_extract_array(unnested_column_value('refundeventlist'), ['ShipmentItemList'], ['ShipmentItemList']) }} as shipmentitemlist,
    {{ json_extract_array(unnested_column_value('refundeventlist'), ['DirectPaymentList'], ['DirectPaymentList']) }} as directpaymentlist,
    {{ json_extract_array(unnested_column_value('refundeventlist'), ['OrderFeeAdjustmentList'], ['OrderFeeAdjustmentList']) }} as orderfeeadjustmentlist,
    {{ json_extract_array(unnested_column_value('refundeventlist'), ['OrderChargeAdjustmentList'], ['OrderChargeAdjustmentList']) }} as orderchargeadjustmentlist,
    {{ json_extract_array(unnested_column_value('refundeventlist'), ['ShipmentFeeAdjustmentList'], ['ShipmentFeeAdjustmentList']) }} as shipmentfeeadjustmentlist,
    {{ json_extract_array(unnested_column_value('refundeventlist'), ['ShipmentItemAdjustmentList'], ['ShipmentItemAdjustmentList']) }} as shipmentitemadjustmentlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- refundeventlist at AU_ListFinancialEvents/RefundEventList
{{ cross_join_unnest('au_listfinancialevents', 'refundeventlist') }}
where 1 = 1
and refundeventlist is not null

