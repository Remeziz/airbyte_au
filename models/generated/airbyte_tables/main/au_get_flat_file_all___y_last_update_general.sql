{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_get_flat_file_all__1st_update_general_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('au_get_flat_file_all__1st_update_general_ab3') }}
select
    sku,
    asin,
    currency,
    {{ adapter.quote('item-tax') }},
    quantity,
    {{ adapter.quote('ship-city') }},
    {{ adapter.quote('item-price') }},
    {{ adapter.quote('ship-state') }},
    {{ adapter.quote('item-status') }},
    {{ adapter.quote('order-status') }},
    {{ adapter.quote('product-name') }},
    {{ adapter.quote('ship-country') }},
    {{ adapter.quote('shipping-tax') }},
    {{ adapter.quote('gift-wrap-tax') }},
    {{ adapter.quote('order-channel') }},
    {{ adapter.quote('promotion-ids') }},
    {{ adapter.quote('purchase-date') }},
    {{ adapter.quote('sales-channel') }},
    {{ adapter.quote('shipping-price') }},
    {{ adapter.quote('amazon-order-id') }},
    {{ adapter.quote('gift-wrap-price') }},
    {{ adapter.quote('ship-postal-code') }},
    {{ adapter.quote('is-business-order') }},
    {{ adapter.quote('last-updated-date') }},
    {{ adapter.quote('merchant-order-id') }},
    {{ adapter.quote('price-designation') }},
    {{ adapter.quote('ship-service-level') }},
    {{ adapter.quote('fulfillment-channel') }},
    {{ adapter.quote('purchase-order-number') }},
    {{ adapter.quote('item-promotion-discount') }},
    {{ adapter.quote('ship-promotion-discount') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_au_get_flat___update_general_hashid
from {{ ref('au_get_flat_file_all__1st_update_general_ab3') }}
-- au_get_flat_file_all___y_last_update_general from {{ source('main', '_airbyte_raw_au_get_f__y_last_update_general') }}
where 1 = 1

