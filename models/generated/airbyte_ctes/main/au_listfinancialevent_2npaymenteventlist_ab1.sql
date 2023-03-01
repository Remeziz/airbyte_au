{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'couponpaymenteventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('couponpaymenteventlist'), ['CouponId'], ['CouponId']) }} as couponid,
    {{ json_extract_scalar(unnested_column_value('couponpaymenteventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract('', unnested_column_value('couponpaymenteventlist'), ['TotalAmount'], ['TotalAmount']) }} as totalamount,
    {{ json_extract('', unnested_column_value('couponpaymenteventlist'), ['FeeComponent'], ['FeeComponent']) }} as feecomponent,
    {{ json_extract_scalar(unnested_column_value('couponpaymenteventlist'), ['PaymentEventId'], ['PaymentEventId']) }} as paymenteventid,
    {{ json_extract('', unnested_column_value('couponpaymenteventlist'), ['ChargeComponent'], ['ChargeComponent']) }} as chargecomponent,
    {{ json_extract_scalar(unnested_column_value('couponpaymenteventlist'), ['ClipOrRedemptionCount'], ['ClipOrRedemptionCount']) }} as cliporredemptioncount,
    {{ json_extract_scalar(unnested_column_value('couponpaymenteventlist'), ['SellerCouponDescription'], ['SellerCouponDescription']) }} as sellercoupondescription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- couponpaymenteventlist at AU_ListFinancialEvents/CouponPaymentEventList
{{ cross_join_unnest('au_listfinancialevents', 'couponpaymenteventlist') }}
where 1 = 1
and couponpaymenteventlist is not null

