{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'sellerdealpaymenteventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('sellerdealpaymenteventlist'), ['dealId'], ['dealId']) }} as dealid,
    {{ json_extract_scalar(unnested_column_value('sellerdealpaymenteventlist'), ['feeType'], ['feeType']) }} as feetype,
    {{ json_extract_scalar(unnested_column_value('sellerdealpaymenteventlist'), ['eventType'], ['eventType']) }} as eventtype,
    {{ json_extract('', unnested_column_value('sellerdealpaymenteventlist'), ['feeAmount'], ['feeAmount']) }} as feeamount,
    {{ json_extract('', unnested_column_value('sellerdealpaymenteventlist'), ['taxAmount'], ['taxAmount']) }} as taxamount,
    {{ json_extract_scalar(unnested_column_value('sellerdealpaymenteventlist'), ['postedDate'], ['postedDate']) }} as posteddate,
    {{ json_extract('', unnested_column_value('sellerdealpaymenteventlist'), ['totalAmount'], ['totalAmount']) }} as totalamount,
    {{ json_extract_scalar(unnested_column_value('sellerdealpaymenteventlist'), ['dealDescription'], ['dealDescription']) }} as dealdescription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- sellerdealpaymenteventlist at AU_ListFinancialEvents/SellerDealPaymentEventList
{{ cross_join_unnest('au_listfinancialevents', 'sellerdealpaymenteventlist') }}
where 1 = 1
and sellerdealpaymenteventlist is not null

