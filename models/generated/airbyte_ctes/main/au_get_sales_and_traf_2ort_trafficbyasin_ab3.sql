{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_get_sales_and_traf_2ort_trafficbyasin_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_get_sales__traffic_report_hashid',
        'sessions',
        'pageviews',
        'browsersessions',
        'browserpageviews',
        'buyboxpercentage',
        'mobileappsessions',
        'sessionpercentage',
        'mobileapppageviews',
        'pageviewspercentage',
        'unitsessionpercentage',
        'browsersessionpercentage',
        'browserpageviewspercentage',
        'mobileappsessionpercentage',
        'mobileapppageviewspercentage',
    ]) }} as _airbyte_trafficbyasin_hashid,
    tmp.*
from {{ ref('au_get_sales_and_traf_2ort_trafficbyasin_ab2') }} tmp
-- trafficbyasin at AU_GET_SALES_AND_TRAFFIC_REPORT/trafficByAsin
where 1 = 1

