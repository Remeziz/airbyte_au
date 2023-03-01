{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_get_sales_and_traf_2ort_trafficbyasin_ab1') }}
select
    _airbyte_au_get_sales__traffic_report_hashid,
    cast(sessions as {{ dbt_utils.type_float() }}) as sessions,
    cast(pageviews as {{ dbt_utils.type_float() }}) as pageviews,
    cast(browsersessions as {{ dbt_utils.type_float() }}) as browsersessions,
    cast(browserpageviews as {{ dbt_utils.type_float() }}) as browserpageviews,
    cast(buyboxpercentage as {{ dbt_utils.type_float() }}) as buyboxpercentage,
    cast(mobileappsessions as {{ dbt_utils.type_float() }}) as mobileappsessions,
    cast(sessionpercentage as {{ dbt_utils.type_float() }}) as sessionpercentage,
    cast(mobileapppageviews as {{ dbt_utils.type_float() }}) as mobileapppageviews,
    cast(pageviewspercentage as {{ dbt_utils.type_float() }}) as pageviewspercentage,
    cast(unitsessionpercentage as {{ dbt_utils.type_float() }}) as unitsessionpercentage,
    cast(browsersessionpercentage as {{ dbt_utils.type_float() }}) as browsersessionpercentage,
    cast(browserpageviewspercentage as {{ dbt_utils.type_float() }}) as browserpageviewspercentage,
    cast(mobileappsessionpercentage as {{ dbt_utils.type_float() }}) as mobileappsessionpercentage,
    cast(mobileapppageviewspercentage as {{ dbt_utils.type_float() }}) as mobileapppageviewspercentage,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_get_sales_and_traf_2ort_trafficbyasin_ab1') }}
-- trafficbyasin at AU_GET_SALES_AND_TRAFFIC_REPORT/trafficByAsin
where 1 = 1

