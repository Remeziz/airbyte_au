{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('main', '_airbyte_raw_au_get_f__y_last_update_general') }}
select
    {{ json_extract_scalar('_airbyte_data', ['sku'], ['sku']) }} as sku,
    {{ json_extract_scalar('_airbyte_data', ['asin'], ['asin']) }} as asin,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['item-tax'], ['item-tax']) }} as {{ adapter.quote('item-tax') }},
    {{ json_extract_scalar('_airbyte_data', ['quantity'], ['quantity']) }} as quantity,
    {{ json_extract_scalar('_airbyte_data', ['ship-city'], ['ship-city']) }} as {{ adapter.quote('ship-city') }},
    {{ json_extract_scalar('_airbyte_data', ['item-price'], ['item-price']) }} as {{ adapter.quote('item-price') }},
    {{ json_extract_scalar('_airbyte_data', ['ship-state'], ['ship-state']) }} as {{ adapter.quote('ship-state') }},
    {{ json_extract_scalar('_airbyte_data', ['item-status'], ['item-status']) }} as {{ adapter.quote('item-status') }},
    {{ json_extract_scalar('_airbyte_data', ['order-status'], ['order-status']) }} as {{ adapter.quote('order-status') }},
    {{ json_extract_scalar('_airbyte_data', ['product-name'], ['product-name']) }} as {{ adapter.quote('product-name') }},
    {{ json_extract_scalar('_airbyte_data', ['ship-country'], ['ship-country']) }} as {{ adapter.quote('ship-country') }},
    {{ json_extract_scalar('_airbyte_data', ['shipping-tax'], ['shipping-tax']) }} as {{ adapter.quote('shipping-tax') }},
    {{ json_extract_scalar('_airbyte_data', ['gift-wrap-tax'], ['gift-wrap-tax']) }} as {{ adapter.quote('gift-wrap-tax') }},
    {{ json_extract_scalar('_airbyte_data', ['order-channel'], ['order-channel']) }} as {{ adapter.quote('order-channel') }},
    {{ json_extract_scalar('_airbyte_data', ['promotion-ids'], ['promotion-ids']) }} as {{ adapter.quote('promotion-ids') }},
    {{ json_extract_scalar('_airbyte_data', ['purchase-date'], ['purchase-date']) }} as {{ adapter.quote('purchase-date') }},
    {{ json_extract_scalar('_airbyte_data', ['sales-channel'], ['sales-channel']) }} as {{ adapter.quote('sales-channel') }},
    {{ json_extract_scalar('_airbyte_data', ['shipping-price'], ['shipping-price']) }} as {{ adapter.quote('shipping-price') }},
    {{ json_extract_scalar('_airbyte_data', ['amazon-order-id'], ['amazon-order-id']) }} as {{ adapter.quote('amazon-order-id') }},
    {{ json_extract_scalar('_airbyte_data', ['gift-wrap-price'], ['gift-wrap-price']) }} as {{ adapter.quote('gift-wrap-price') }},
    {{ json_extract_scalar('_airbyte_data', ['ship-postal-code'], ['ship-postal-code']) }} as {{ adapter.quote('ship-postal-code') }},
    {{ json_extract_scalar('_airbyte_data', ['is-business-order'], ['is-business-order']) }} as {{ adapter.quote('is-business-order') }},
    {{ json_extract_scalar('_airbyte_data', ['last-updated-date'], ['last-updated-date']) }} as {{ adapter.quote('last-updated-date') }},
    {{ json_extract_scalar('_airbyte_data', ['merchant-order-id'], ['merchant-order-id']) }} as {{ adapter.quote('merchant-order-id') }},
    {{ json_extract_scalar('_airbyte_data', ['price-designation'], ['price-designation']) }} as {{ adapter.quote('price-designation') }},
    {{ json_extract_scalar('_airbyte_data', ['ship-service-level'], ['ship-service-level']) }} as {{ adapter.quote('ship-service-level') }},
    {{ json_extract_scalar('_airbyte_data', ['fulfillment-channel'], ['fulfillment-channel']) }} as {{ adapter.quote('fulfillment-channel') }},
    {{ json_extract_scalar('_airbyte_data', ['purchase-order-number'], ['purchase-order-number']) }} as {{ adapter.quote('purchase-order-number') }},
    {{ json_extract_scalar('_airbyte_data', ['item-promotion-discount'], ['item-promotion-discount']) }} as {{ adapter.quote('item-promotion-discount') }},
    {{ json_extract_scalar('_airbyte_data', ['ship-promotion-discount'], ['ship-promotion-discount']) }} as {{ adapter.quote('ship-promotion-discount') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('main', '_airbyte_raw_au_get_f__y_last_update_general') }} as table_alias
-- au_get_flat_file_all___y_last_update_general
where 1 = 1

