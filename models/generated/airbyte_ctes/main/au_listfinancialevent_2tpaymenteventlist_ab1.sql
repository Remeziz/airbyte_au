{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'sellerreviewenrollmentpaymenteventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('sellerreviewenrollmentpaymenteventlist'), ['ParentASIN'], ['ParentASIN']) }} as parentasin,
    {{ json_extract_scalar(unnested_column_value('sellerreviewenrollmentpaymenteventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract('', unnested_column_value('sellerreviewenrollmentpaymenteventlist'), ['TotalAmount'], ['TotalAmount']) }} as totalamount,
    {{ json_extract_scalar(unnested_column_value('sellerreviewenrollmentpaymenteventlist'), ['EnrollmentId'], ['EnrollmentId']) }} as enrollmentid,
    {{ json_extract('', unnested_column_value('sellerreviewenrollmentpaymenteventlist'), ['FeeComponent'], ['FeeComponent']) }} as feecomponent,
    {{ json_extract('', unnested_column_value('sellerreviewenrollmentpaymenteventlist'), ['ChargeComponent'], ['ChargeComponent']) }} as chargecomponent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- sellerreviewenrollmentpaymenteventlist at AU_ListFinancialEvents/SellerReviewEnrollmentPaymentEventList
{{ cross_join_unnest('au_listfinancialevents', 'sellerreviewenrollmentpaymenteventlist') }}
where 1 = 1
and sellerreviewenrollmentpaymenteventlist is not null

