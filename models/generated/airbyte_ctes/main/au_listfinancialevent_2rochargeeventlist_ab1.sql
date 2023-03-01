{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'retrochargeeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract('', unnested_column_value('retrochargeeventlist'), ['BaseTax'], ['BaseTax']) }} as basetax,
    {{ json_extract_scalar(unnested_column_value('retrochargeeventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract('', unnested_column_value('retrochargeeventlist'), ['ShippingTax'], ['ShippingTax']) }} as shippingtax,
    {{ json_extract_scalar(unnested_column_value('retrochargeeventlist'), ['AmazonOrderId'], ['AmazonOrderId']) }} as amazonorderid,
    {{ json_extract_scalar(unnested_column_value('retrochargeeventlist'), ['MarketplaceName'], ['MarketplaceName']) }} as marketplacename,
    {{ json_extract_scalar(unnested_column_value('retrochargeeventlist'), ['RetrochargeEventType'], ['RetrochargeEventType']) }} as retrochargeeventtype,
    {{ json_extract_array(unnested_column_value('retrochargeeventlist'), ['RetrochargeTaxWithheldList'], ['RetrochargeTaxWithheldList']) }} as retrochargetaxwithheldlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- retrochargeeventlist at AU_ListFinancialEvents/RetrochargeEventList
{{ cross_join_unnest('au_listfinancialevents', 'retrochargeeventlist') }}
where 1 = 1
and retrochargeeventlist is not null

