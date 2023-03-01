{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_get_flat_file_all__1st_update_general_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sku',
        'asin',
        'currency',
        adapter.quote('item-tax'),
        'quantity',
        adapter.quote('ship-city'),
        adapter.quote('item-price'),
        adapter.quote('ship-state'),
        adapter.quote('item-status'),
        adapter.quote('order-status'),
        adapter.quote('product-name'),
        adapter.quote('ship-country'),
        adapter.quote('shipping-tax'),
        adapter.quote('gift-wrap-tax'),
        adapter.quote('order-channel'),
        adapter.quote('promotion-ids'),
        adapter.quote('purchase-date'),
        adapter.quote('sales-channel'),
        adapter.quote('shipping-price'),
        adapter.quote('amazon-order-id'),
        adapter.quote('gift-wrap-price'),
        adapter.quote('ship-postal-code'),
        adapter.quote('is-business-order'),
        adapter.quote('last-updated-date'),
        adapter.quote('merchant-order-id'),
        adapter.quote('price-designation'),
        adapter.quote('ship-service-level'),
        adapter.quote('fulfillment-channel'),
        adapter.quote('purchase-order-number'),
        adapter.quote('item-promotion-discount'),
        adapter.quote('ship-promotion-discount'),
    ]) }} as _airbyte_au_get_flat___update_general_hashid,
    tmp.*
from {{ ref('au_get_flat_file_all__1st_update_general_ab2') }} tmp
-- au_get_flat_file_all___y_last_update_general
where 1 = 1

