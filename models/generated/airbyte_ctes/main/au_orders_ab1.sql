{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('main', '_airbyte_raw_au_orders') }}
select
    {{ json_extract_scalar('_airbyte_data', ['IsISPU'], ['IsISPU']) }} as isispu,
    {{ json_extract_scalar('_airbyte_data', ['IsPrime'], ['IsPrime']) }} as isprime,
    {{ json_extract_scalar('_airbyte_data', ['OrderType'], ['OrderType']) }} as ordertype,
    {{ json_extract_scalar('_airbyte_data', ['seller_id'], ['seller_id']) }} as seller_id,
    {{ json_extract_scalar('_airbyte_data', ['IsSoldByAB'], ['IsSoldByAB']) }} as issoldbyab,
    {{ json_extract('table_alias', '_airbyte_data', ['OrderTotal'], ['OrderTotal']) }} as ordertotal,
    {{ json_extract_scalar('_airbyte_data', ['OrderStatus'], ['OrderStatus']) }} as orderstatus,
    {{ json_extract_scalar('_airbyte_data', ['PurchaseDate'], ['PurchaseDate']) }} as purchasedate,
    {{ json_extract_scalar('_airbyte_data', ['SalesChannel'], ['SalesChannel']) }} as saleschannel,
    {{ json_extract_scalar('_airbyte_data', ['AmazonOrderId'], ['AmazonOrderId']) }} as amazonorderid,
    {{ json_extract_scalar('_airbyte_data', ['MarketplaceId'], ['MarketplaceId']) }} as marketplaceid,
    {{ json_extract_scalar('_airbyte_data', ['PaymentMethod'], ['PaymentMethod']) }} as paymentmethod,
    {{ json_extract_scalar('_airbyte_data', ['SellerOrderId'], ['SellerOrderId']) }} as sellerorderid,
    {{ json_extract_scalar('_airbyte_data', ['IsPremiumOrder'], ['IsPremiumOrder']) }} as ispremiumorder,
    {{ json_extract_scalar('_airbyte_data', ['LastUpdateDate'], ['LastUpdateDate']) }} as lastupdatedate,
    {{ json_extract_scalar('_airbyte_data', ['LatestShipDate'], ['LatestShipDate']) }} as latestshipdate,
    {{ json_extract_scalar('_airbyte_data', ['IsBusinessOrder'], ['IsBusinessOrder']) }} as isbusinessorder,
    {{ json_extract_scalar('_airbyte_data', ['EarliestShipDate'], ['EarliestShipDate']) }} as earliestshipdate,
    {{ json_extract_scalar('_airbyte_data', ['ShipServiceLevel'], ['ShipServiceLevel']) }} as shipservicelevel,
    {{ json_extract_scalar('_airbyte_data', ['FulfillmentChannel'], ['FulfillmentChannel']) }} as fulfillmentchannel,
    {{ json_extract_scalar('_airbyte_data', ['IsReplacementOrder'], ['IsReplacementOrder']) }} as isreplacementorder,
    {{ json_extract_scalar('_airbyte_data', ['NumberOfItemsShipped'], ['NumberOfItemsShipped']) }} as numberofitemsshipped,
    {{ json_extract_string_array('_airbyte_data', ['PaymentMethodDetails'], ['PaymentMethodDetails']) }} as paymentmethoddetails,
    {{ json_extract_scalar('_airbyte_data', ['IsGlobalExpressEnabled'], ['IsGlobalExpressEnabled']) }} as isglobalexpressenabled,
    {{ json_extract_scalar('_airbyte_data', ['NumberOfItemsUnshipped'], ['NumberOfItemsUnshipped']) }} as numberofitemsunshipped,
    {{ json_extract_scalar('_airbyte_data', ['ShipmentServiceLevelCategory'], ['ShipmentServiceLevelCategory']) }} as shipmentservicelevelcategory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('main', '_airbyte_raw_au_orders') }} as table_alias
-- au_orders
where 1 = 1

