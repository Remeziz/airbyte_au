{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'guaranteeclaimeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('guaranteeclaimeventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract_array(unnested_column_value('guaranteeclaimeventlist'), ['OrderFeeList'], ['OrderFeeList']) }} as orderfeelist,
    {{ json_extract_scalar(unnested_column_value('guaranteeclaimeventlist'), ['AmazonOrderId'], ['AmazonOrderId']) }} as amazonorderid,
    {{ json_extract_scalar(unnested_column_value('guaranteeclaimeventlist'), ['SellerOrderId'], ['SellerOrderId']) }} as sellerorderid,
    {{ json_extract_scalar(unnested_column_value('guaranteeclaimeventlist'), ['MarketplaceName'], ['MarketplaceName']) }} as marketplacename,
    {{ json_extract_array(unnested_column_value('guaranteeclaimeventlist'), ['OrderChargeList'], ['OrderChargeList']) }} as orderchargelist,
    {{ json_extract_array(unnested_column_value('guaranteeclaimeventlist'), ['ShipmentFeeList'], ['ShipmentFeeList']) }} as shipmentfeelist,
    {{ json_extract_array(unnested_column_value('guaranteeclaimeventlist'), ['ShipmentItemList'], ['ShipmentItemList']) }} as shipmentitemlist,
    {{ json_extract_array(unnested_column_value('guaranteeclaimeventlist'), ['DirectPaymentList'], ['DirectPaymentList']) }} as directpaymentlist,
    {{ json_extract_array(unnested_column_value('guaranteeclaimeventlist'), ['OrderFeeAdjustmentList'], ['OrderFeeAdjustmentList']) }} as orderfeeadjustmentlist,
    {{ json_extract_array(unnested_column_value('guaranteeclaimeventlist'), ['OrderChargeAdjustmentList'], ['OrderChargeAdjustmentList']) }} as orderchargeadjustmentlist,
    {{ json_extract_array(unnested_column_value('guaranteeclaimeventlist'), ['ShipmentFeeAdjustmentList'], ['ShipmentFeeAdjustmentList']) }} as shipmentfeeadjustmentlist,
    {{ json_extract_array(unnested_column_value('guaranteeclaimeventlist'), ['ShipmentItemAdjustmentList'], ['ShipmentItemAdjustmentList']) }} as shipmentitemadjustmentlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- guaranteeclaimeventlist at AU_ListFinancialEvents/GuaranteeClaimEventList
{{ cross_join_unnest('au_listfinancialevents', 'guaranteeclaimeventlist') }}
where 1 = 1
and guaranteeclaimeventlist is not null

