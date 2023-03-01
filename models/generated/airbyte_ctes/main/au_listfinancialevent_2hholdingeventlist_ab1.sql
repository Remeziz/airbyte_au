{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'taxwithholdingeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract('', unnested_column_value('taxwithholdingeventlist'), ['BaseAmount'], ['BaseAmount']) }} as baseamount,
    {{ json_extract_scalar(unnested_column_value('taxwithholdingeventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract('', unnested_column_value('taxwithholdingeventlist'), ['WithheldAmount'], ['WithheldAmount']) }} as withheldamount,
    {{ json_extract('', unnested_column_value('taxwithholdingeventlist'), ['TaxWithholdingPeriod'], ['TaxWithholdingPeriod']) }} as taxwithholdingperiod,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- taxwithholdingeventlist at AU_ListFinancialEvents/TaxWithholdingEventList
{{ cross_join_unnest('au_listfinancialevents', 'taxwithholdingeventlist') }}
where 1 = 1
and taxwithholdingeventlist is not null

