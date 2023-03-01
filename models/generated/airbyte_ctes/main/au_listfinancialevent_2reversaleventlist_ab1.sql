{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'affordabilityexpensereversaleventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('affordabilityexpensereversaleventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract('', unnested_column_value('affordabilityexpensereversaleventlist'), ['BaseExpense'], ['BaseExpense']) }} as baseexpense,
    {{ json_extract('', unnested_column_value('affordabilityexpensereversaleventlist'), ['TaxTypeCGST'], ['TaxTypeCGST']) }} as taxtypecgst,
    {{ json_extract('', unnested_column_value('affordabilityexpensereversaleventlist'), ['TaxTypeIGST'], ['TaxTypeIGST']) }} as taxtypeigst,
    {{ json_extract('', unnested_column_value('affordabilityexpensereversaleventlist'), ['TaxTypeSGST'], ['TaxTypeSGST']) }} as taxtypesgst,
    {{ json_extract('', unnested_column_value('affordabilityexpensereversaleventlist'), ['TotalExpense'], ['TotalExpense']) }} as totalexpense,
    {{ json_extract_scalar(unnested_column_value('affordabilityexpensereversaleventlist'), ['AmazonOrderId'], ['AmazonOrderId']) }} as amazonorderid,
    {{ json_extract_scalar(unnested_column_value('affordabilityexpensereversaleventlist'), ['MarketplaceId'], ['MarketplaceId']) }} as marketplaceid,
    {{ json_extract_scalar(unnested_column_value('affordabilityexpensereversaleventlist'), ['TransactionType'], ['TransactionType']) }} as transactiontype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- affordabilityexpensereversaleventlist at AU_ListFinancialEvents/AffordabilityExpenseReversalEventList
{{ cross_join_unnest('au_listfinancialevents', 'affordabilityexpensereversaleventlist') }}
where 1 = 1
and affordabilityexpensereversaleventlist is not null

