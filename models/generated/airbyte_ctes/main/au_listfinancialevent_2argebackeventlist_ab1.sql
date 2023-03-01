{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'chargebackeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('chargebackeventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract_array(unnested_column_value('chargebackeventlist'), ['OrderFeeList'], ['OrderFeeList']) }} as orderfeelist,
    {{ json_extract_scalar(unnested_column_value('chargebackeventlist'), ['AmazonOrderId'], ['AmazonOrderId']) }} as amazonorderid,
    {{ json_extract_scalar(unnested_column_value('chargebackeventlist'), ['SellerOrderId'], ['SellerOrderId']) }} as sellerorderid,
    {{ json_extract_scalar(unnested_column_value('chargebackeventlist'), ['MarketplaceName'], ['MarketplaceName']) }} as marketplacename,
    {{ json_extract_array(unnested_column_value('chargebackeventlist'), ['OrderChargeList'], ['OrderChargeList']) }} as orderchargelist,
    {{ json_extract_array(unnested_column_value('chargebackeventlist'), ['ShipmentFeeList'], ['ShipmentFeeList']) }} as shipmentfeelist,
    {{ json_extract_array(unnested_column_value('chargebackeventlist'), ['ShipmentItemList'], ['ShipmentItemList']) }} as shipmentitemlist,
    {{ json_extract_array(unnested_column_value('chargebackeventlist'), ['DirectPaymentList'], ['DirectPaymentList']) }} as directpaymentlist,
    {{ json_extract_array(unnested_column_value('chargebackeventlist'), ['OrderFeeAdjustmentList'], ['OrderFeeAdjustmentList']) }} as orderfeeadjustmentlist,
    {{ json_extract_array(unnested_column_value('chargebackeventlist'), ['OrderChargeAdjustmentList'], ['OrderChargeAdjustmentList']) }} as orderchargeadjustmentlist,
    {{ json_extract_array(unnested_column_value('chargebackeventlist'), ['ShipmentFeeAdjustmentList'], ['ShipmentFeeAdjustmentList']) }} as shipmentfeeadjustmentlist,
    {{ json_extract_array(unnested_column_value('chargebackeventlist'), ['ShipmentItemAdjustmentList'], ['ShipmentItemAdjustmentList']) }} as shipmentitemadjustmentlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- chargebackeventlist at AU_ListFinancialEvents/ChargebackEventList
{{ cross_join_unnest('au_listfinancialevents', 'chargebackeventlist') }}
where 1 = 1
and chargebackeventlist is not null

