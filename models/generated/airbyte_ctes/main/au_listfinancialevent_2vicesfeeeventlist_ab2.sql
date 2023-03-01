{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2vicesfeeeventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(asin as {{ dbt_utils.type_string() }}(1024)) as asin,
    feelist,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    cast(imagingrequestbillingitemid as {{ dbt_utils.type_string() }}(1024)) as imagingrequestbillingitemid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2vicesfeeeventlist_ab1') }}
-- imagingservicesfeeeventlist at AU_ListFinancialEvents/ImagingServicesFeeEventList
where 1 = 1

