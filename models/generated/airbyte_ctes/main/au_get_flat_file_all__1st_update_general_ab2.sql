{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_get_flat_file_all__1st_update_general_ab1') }}
select
    cast(sku as {{ dbt_utils.type_string() }}(1024)) as sku,
    cast(asin as {{ dbt_utils.type_string() }}(1024)) as asin,
    cast(currency as {{ dbt_utils.type_string() }}(1024)) as currency,
    cast({{ adapter.quote('item-tax') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('item-tax') }},
    cast(quantity as {{ dbt_utils.type_string() }}(1024)) as quantity,
    cast({{ adapter.quote('ship-city') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('ship-city') }},
    cast({{ adapter.quote('item-price') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('item-price') }},
    cast({{ adapter.quote('ship-state') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('ship-state') }},
    cast({{ adapter.quote('item-status') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('item-status') }},
    cast({{ adapter.quote('order-status') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('order-status') }},
    cast({{ adapter.quote('product-name') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('product-name') }},
    cast({{ adapter.quote('ship-country') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('ship-country') }},
    cast({{ adapter.quote('shipping-tax') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('shipping-tax') }},
    cast({{ adapter.quote('gift-wrap-tax') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('gift-wrap-tax') }},
    cast({{ adapter.quote('order-channel') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('order-channel') }},
    cast({{ adapter.quote('promotion-ids') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('promotion-ids') }},
    cast({{ empty_string_to_null(adapter.quote('purchase-date')) }} as {{ type_timestamp_with_timezone() }}) as {{ adapter.quote('purchase-date') }},
    cast({{ adapter.quote('sales-channel') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('sales-channel') }},
    cast({{ adapter.quote('shipping-price') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('shipping-price') }},
    cast({{ adapter.quote('amazon-order-id') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('amazon-order-id') }},
    cast({{ adapter.quote('gift-wrap-price') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('gift-wrap-price') }},
    cast({{ adapter.quote('ship-postal-code') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('ship-postal-code') }},
    cast({{ adapter.quote('is-business-order') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('is-business-order') }},
    cast({{ empty_string_to_null(adapter.quote('last-updated-date')) }} as {{ type_timestamp_with_timezone() }}) as {{ adapter.quote('last-updated-date') }},
    cast({{ adapter.quote('merchant-order-id') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('merchant-order-id') }},
    cast({{ adapter.quote('price-designation') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('price-designation') }},
    cast({{ adapter.quote('ship-service-level') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('ship-service-level') }},
    cast({{ adapter.quote('fulfillment-channel') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('fulfillment-channel') }},
    cast({{ adapter.quote('purchase-order-number') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('purchase-order-number') }},
    cast({{ adapter.quote('item-promotion-discount') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('item-promotion-discount') }},
    cast({{ adapter.quote('ship-promotion-discount') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('ship-promotion-discount') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_get_flat_file_all__1st_update_general_ab1') }}
-- au_get_flat_file_all___y_last_update_general
where 1 = 1

