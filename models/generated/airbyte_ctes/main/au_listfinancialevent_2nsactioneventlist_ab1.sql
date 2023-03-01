{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'networkcomminglingtransactioneventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('networkcomminglingtransactioneventlist'), ['ASIN'], ['ASIN']) }} as asin,
    {{ json_extract('', unnested_column_value('networkcomminglingtransactioneventlist'), ['TaxAmount'], ['TaxAmount']) }} as taxamount,
    {{ json_extract_scalar(unnested_column_value('networkcomminglingtransactioneventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract_scalar(unnested_column_value('networkcomminglingtransactioneventlist'), ['SwapReason'], ['SwapReason']) }} as swapreason,
    {{ json_extract_scalar(unnested_column_value('networkcomminglingtransactioneventlist'), ['MarketplaceId'], ['MarketplaceId']) }} as marketplaceid,
    {{ json_extract_scalar(unnested_column_value('networkcomminglingtransactioneventlist'), ['TransactionType'], ['TransactionType']) }} as transactiontype,
    {{ json_extract_scalar(unnested_column_value('networkcomminglingtransactioneventlist'), ['NetCoTransactionID'], ['NetCoTransactionID']) }} as netcotransactionid,
    {{ json_extract('', unnested_column_value('networkcomminglingtransactioneventlist'), ['TaxExclusiveAmount'], ['TaxExclusiveAmount']) }} as taxexclusiveamount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- networkcomminglingtransactioneventlist at AU_ListFinancialEvents/NetworkComminglingTransactionEventList
{{ cross_join_unnest('au_listfinancialevents', 'networkcomminglingtransactioneventlist') }}
where 1 = 1
and networkcomminglingtransactioneventlist is not null

