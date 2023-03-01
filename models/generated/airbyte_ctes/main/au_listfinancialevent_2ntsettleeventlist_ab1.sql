{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'shipmentsettleeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('shipmentsettleeventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract_array(unnested_column_value('shipmentsettleeventlist'), ['OrderFeeList'], ['OrderFeeList']) }} as orderfeelist,
    {{ json_extract_scalar(unnested_column_value('shipmentsettleeventlist'), ['AmazonOrderId'], ['AmazonOrderId']) }} as amazonorderid,
    {{ json_extract_scalar(unnested_column_value('shipmentsettleeventlist'), ['SellerOrderId'], ['SellerOrderId']) }} as sellerorderid,
    {{ json_extract_scalar(unnested_column_value('shipmentsettleeventlist'), ['MarketplaceName'], ['MarketplaceName']) }} as marketplacename,
    {{ json_extract_array(unnested_column_value('shipmentsettleeventlist'), ['OrderChargeList'], ['OrderChargeList']) }} as orderchargelist,
    {{ json_extract_array(unnested_column_value('shipmentsettleeventlist'), ['ShipmentFeeList'], ['ShipmentFeeList']) }} as shipmentfeelist,
    {{ json_extract_array(unnested_column_value('shipmentsettleeventlist'), ['ShipmentItemList'], ['ShipmentItemList']) }} as shipmentitemlist,
    {{ json_extract_array(unnested_column_value('shipmentsettleeventlist'), ['DirectPaymentList'], ['DirectPaymentList']) }} as directpaymentlist,
    {{ json_extract_array(unnested_column_value('shipmentsettleeventlist'), ['OrderFeeAdjustmentList'], ['OrderFeeAdjustmentList']) }} as orderfeeadjustmentlist,
    {{ json_extract_array(unnested_column_value('shipmentsettleeventlist'), ['OrderChargeAdjustmentList'], ['OrderChargeAdjustmentList']) }} as orderchargeadjustmentlist,
    {{ json_extract_array(unnested_column_value('shipmentsettleeventlist'), ['ShipmentFeeAdjustmentList'], ['ShipmentFeeAdjustmentList']) }} as shipmentfeeadjustmentlist,
    {{ json_extract_array(unnested_column_value('shipmentsettleeventlist'), ['ShipmentItemAdjustmentList'], ['ShipmentItemAdjustmentList']) }} as shipmentitemadjustmentlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- shipmentsettleeventlist at AU_ListFinancialEvents/ShipmentSettleEventList
{{ cross_join_unnest('au_listfinancialevents', 'shipmentsettleeventlist') }}
where 1 = 1
and shipmentsettleeventlist is not null

