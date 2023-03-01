{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'safetreimbursementeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('safetreimbursementeventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract_scalar(unnested_column_value('safetreimbursementeventlist'), ['ReasonCode'], ['ReasonCode']) }} as reasoncode,
    {{ json_extract_scalar(unnested_column_value('safetreimbursementeventlist'), ['SAFETClaimId'], ['SAFETClaimId']) }} as safetclaimid,
    {{ json_extract('', unnested_column_value('safetreimbursementeventlist'), ['ReimbursedAmount'], ['ReimbursedAmount']) }} as reimbursedamount,
    {{ json_extract_array(unnested_column_value('safetreimbursementeventlist'), ['SAFETReimbursementItemList'], ['SAFETReimbursementItemList']) }} as safetreimbursementitemlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- safetreimbursementeventlist at AU_ListFinancialEvents/SAFETReimbursementEventList
{{ cross_join_unnest('au_listfinancialevents', 'safetreimbursementeventlist') }}
where 1 = 1
and safetreimbursementeventlist is not null

