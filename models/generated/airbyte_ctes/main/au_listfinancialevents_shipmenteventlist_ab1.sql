{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'shipmenteventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('shipmenteventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract_array(unnested_column_value('shipmenteventlist'), ['OrderFeeList'], ['OrderFeeList']) }} as orderfeelist,
    {{ json_extract_scalar(unnested_column_value('shipmenteventlist'), ['AmazonOrderId'], ['AmazonOrderId']) }} as amazonorderid,
    {{ json_extract_scalar(unnested_column_value('shipmenteventlist'), ['SellerOrderId'], ['SellerOrderId']) }} as sellerorderid,
    {{ json_extract_scalar(unnested_column_value('shipmenteventlist'), ['MarketplaceName'], ['MarketplaceName']) }} as marketplacename,
    {{ json_extract_array(unnested_column_value('shipmenteventlist'), ['OrderChargeList'], ['OrderChargeList']) }} as orderchargelist,
    {{ json_extract_array(unnested_column_value('shipmenteventlist'), ['ShipmentFeeList'], ['ShipmentFeeList']) }} as shipmentfeelist,
    {{ json_extract_array(unnested_column_value('shipmenteventlist'), ['ShipmentItemList'], ['ShipmentItemList']) }} as shipmentitemlist,
    {{ json_extract_array(unnested_column_value('shipmenteventlist'), ['DirectPaymentList'], ['DirectPaymentList']) }} as directpaymentlist,
    {{ json_extract_array(unnested_column_value('shipmenteventlist'), ['OrderFeeAdjustmentList'], ['OrderFeeAdjustmentList']) }} as orderfeeadjustmentlist,
    {{ json_extract_array(unnested_column_value('shipmenteventlist'), ['OrderChargeAdjustmentList'], ['OrderChargeAdjustmentList']) }} as orderchargeadjustmentlist,
    {{ json_extract_array(unnested_column_value('shipmenteventlist'), ['ShipmentFeeAdjustmentList'], ['ShipmentFeeAdjustmentList']) }} as shipmentfeeadjustmentlist,
    {{ json_extract_array(unnested_column_value('shipmenteventlist'), ['ShipmentItemAdjustmentList'], ['ShipmentItemAdjustmentList']) }} as shipmentitemadjustmentlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- shipmenteventlist at AU_ListFinancialEvents/ShipmentEventList
{{ cross_join_unnest('au_listfinancialevents', 'shipmenteventlist') }}
where 1 = 1
and shipmenteventlist is not null

