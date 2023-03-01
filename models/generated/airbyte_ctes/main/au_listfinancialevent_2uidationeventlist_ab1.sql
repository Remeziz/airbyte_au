{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'fbaliquidationeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('fbaliquidationeventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract('', unnested_column_value('fbaliquidationeventlist'), ['LiquidationFeeAmount'], ['LiquidationFeeAmount']) }} as liquidationfeeamount,
    {{ json_extract_scalar(unnested_column_value('fbaliquidationeventlist'), ['OriginalRemovalOrderId'], ['OriginalRemovalOrderId']) }} as originalremovalorderid,
    {{ json_extract('', unnested_column_value('fbaliquidationeventlist'), ['LiquidationProceedsAmount'], ['LiquidationProceedsAmount']) }} as liquidationproceedsamount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- fbaliquidationeventlist at AU_ListFinancialEvents/FBALiquidationEventList
{{ cross_join_unnest('au_listfinancialevents', 'fbaliquidationeventlist') }}
where 1 = 1
and fbaliquidationeventlist is not null

