{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'loanservicingeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract('', unnested_column_value('loanservicingeventlist'), ['LoanAmount'], ['LoanAmount']) }} as loanamount,
    {{ json_extract_scalar(unnested_column_value('loanservicingeventlist'), ['SourceBusinessEventType'], ['SourceBusinessEventType']) }} as sourcebusinesseventtype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- loanservicingeventlist at AU_ListFinancialEvents/LoanServicingEventList
{{ cross_join_unnest('au_listfinancialevents', 'loanservicingeventlist') }}
where 1 = 1
and loanservicingeventlist is not null

