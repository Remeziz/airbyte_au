{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'imagingservicesfeeeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('imagingservicesfeeeventlist'), ['ASIN'], ['ASIN']) }} as asin,
    {{ json_extract_array(unnested_column_value('imagingservicesfeeeventlist'), ['FeeList'], ['FeeList']) }} as feelist,
    {{ json_extract_scalar(unnested_column_value('imagingservicesfeeeventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract_scalar(unnested_column_value('imagingservicesfeeeventlist'), ['ImagingRequestBillingItemID'], ['ImagingRequestBillingItemID']) }} as imagingrequestbillingitemid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- imagingservicesfeeeventlist at AU_ListFinancialEvents/ImagingServicesFeeEventList
{{ cross_join_unnest('au_listfinancialevents', 'imagingservicesfeeeventlist') }}
where 1 = 1
and imagingservicesfeeeventlist is not null

