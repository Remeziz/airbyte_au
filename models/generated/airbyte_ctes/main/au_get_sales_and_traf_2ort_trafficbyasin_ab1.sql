{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_get_sales_and_traffic_report') }}
select
    _airbyte_au_get_sales__traffic_report_hashid,
    {{ json_extract_scalar('trafficbyasin', ['sessions'], ['sessions']) }} as sessions,
    {{ json_extract_scalar('trafficbyasin', ['pageViews'], ['pageViews']) }} as pageviews,
    {{ json_extract_scalar('trafficbyasin', ['browserSessions'], ['browserSessions']) }} as browsersessions,
    {{ json_extract_scalar('trafficbyasin', ['browserPageViews'], ['browserPageViews']) }} as browserpageviews,
    {{ json_extract_scalar('trafficbyasin', ['buyBoxPercentage'], ['buyBoxPercentage']) }} as buyboxpercentage,
    {{ json_extract_scalar('trafficbyasin', ['mobileAppSessions'], ['mobileAppSessions']) }} as mobileappsessions,
    {{ json_extract_scalar('trafficbyasin', ['sessionPercentage'], ['sessionPercentage']) }} as sessionpercentage,
    {{ json_extract_scalar('trafficbyasin', ['mobileAppPageViews'], ['mobileAppPageViews']) }} as mobileapppageviews,
    {{ json_extract_scalar('trafficbyasin', ['pageViewsPercentage'], ['pageViewsPercentage']) }} as pageviewspercentage,
    {{ json_extract_scalar('trafficbyasin', ['unitSessionPercentage'], ['unitSessionPercentage']) }} as unitsessionpercentage,
    {{ json_extract_scalar('trafficbyasin', ['browserSessionPercentage'], ['browserSessionPercentage']) }} as browsersessionpercentage,
    {{ json_extract_scalar('trafficbyasin', ['browserPageViewsPercentage'], ['browserPageViewsPercentage']) }} as browserpageviewspercentage,
    {{ json_extract_scalar('trafficbyasin', ['mobileAppSessionPercentage'], ['mobileAppSessionPercentage']) }} as mobileappsessionpercentage,
    {{ json_extract_scalar('trafficbyasin', ['mobileAppPageViewsPercentage'], ['mobileAppPageViewsPercentage']) }} as mobileapppageviewspercentage,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_get_sales_and_traffic_report') }} as table_alias
-- trafficbyasin at AU_GET_SALES_AND_TRAFFIC_REPORT/trafficByAsin
where 1 = 1
and trafficbyasin is not null

