{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2rvicefeeeventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(asin as {{ dbt_utils.type_string() }}(1024)) as asin,
    cast(fnsku as {{ dbt_utils.type_string() }}(1024)) as fnsku,
    feelist,
    cast(feereason as {{ dbt_utils.type_string() }}(1024)) as feereason,
    cast(sellersku as {{ dbt_utils.type_string() }}(1024)) as sellersku,
    cast(amazonorderid as {{ dbt_utils.type_string() }}(1024)) as amazonorderid,
    cast(feedescription as {{ dbt_utils.type_string() }}(1024)) as feedescription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2rvicefeeeventlist_ab1') }}
-- servicefeeeventlist at AU_ListFinancialEvents/ServiceFeeEventList
where 1 = 1

