{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'servicefeeeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('servicefeeeventlist'), ['ASIN'], ['ASIN']) }} as asin,
    {{ json_extract_scalar(unnested_column_value('servicefeeeventlist'), ['FnSKU'], ['FnSKU']) }} as fnsku,
    {{ json_extract_array(unnested_column_value('servicefeeeventlist'), ['FeeList'], ['FeeList']) }} as feelist,
    {{ json_extract_scalar(unnested_column_value('servicefeeeventlist'), ['FeeReason'], ['FeeReason']) }} as feereason,
    {{ json_extract_scalar(unnested_column_value('servicefeeeventlist'), ['SellerSKU'], ['SellerSKU']) }} as sellersku,
    {{ json_extract_scalar(unnested_column_value('servicefeeeventlist'), ['AmazonOrderId'], ['AmazonOrderId']) }} as amazonorderid,
    {{ json_extract_scalar(unnested_column_value('servicefeeeventlist'), ['FeeDescription'], ['FeeDescription']) }} as feedescription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- servicefeeeventlist at AU_ListFinancialEvents/ServiceFeeEventList
{{ cross_join_unnest('au_listfinancialevents', 'servicefeeeventlist') }}
where 1 = 1
and servicefeeeventlist is not null

