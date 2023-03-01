{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'affordabilityexpenseeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('affordabilityexpenseeventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract('', unnested_column_value('affordabilityexpenseeventlist'), ['BaseExpense'], ['BaseExpense']) }} as baseexpense,
    {{ json_extract('', unnested_column_value('affordabilityexpenseeventlist'), ['TaxTypeCGST'], ['TaxTypeCGST']) }} as taxtypecgst,
    {{ json_extract('', unnested_column_value('affordabilityexpenseeventlist'), ['TaxTypeIGST'], ['TaxTypeIGST']) }} as taxtypeigst,
    {{ json_extract('', unnested_column_value('affordabilityexpenseeventlist'), ['TaxTypeSGST'], ['TaxTypeSGST']) }} as taxtypesgst,
    {{ json_extract('', unnested_column_value('affordabilityexpenseeventlist'), ['TotalExpense'], ['TotalExpense']) }} as totalexpense,
    {{ json_extract_scalar(unnested_column_value('affordabilityexpenseeventlist'), ['AmazonOrderId'], ['AmazonOrderId']) }} as amazonorderid,
    {{ json_extract_scalar(unnested_column_value('affordabilityexpenseeventlist'), ['MarketplaceId'], ['MarketplaceId']) }} as marketplaceid,
    {{ json_extract_scalar(unnested_column_value('affordabilityexpenseeventlist'), ['TransactionType'], ['TransactionType']) }} as transactiontype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- affordabilityexpenseeventlist at AU_ListFinancialEvents/AffordabilityExpenseEventList
{{ cross_join_unnest('au_listfinancialevents', 'affordabilityexpenseeventlist') }}
where 1 = 1
and affordabilityexpenseeventlist is not null

