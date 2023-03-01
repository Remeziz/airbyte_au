{{ config(
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_get_sales_and_traf_2ort_trafficbyasin_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('au_get_sales_and_traf_2ort_trafficbyasin_ab3') }}
select
    _airbyte_au_get_sales__traffic_report_hashid,
    sessions,
    pageviews,
    browsersessions,
    browserpageviews,
    buyboxpercentage,
    mobileappsessions,
    sessionpercentage,
    mobileapppageviews,
    pageviewspercentage,
    unitsessionpercentage,
    browsersessionpercentage,
    browserpageviewspercentage,
    mobileappsessionpercentage,
    mobileapppageviewspercentage,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_trafficbyasin_hashid
from {{ ref('au_get_sales_and_traf_2ort_trafficbyasin_ab3') }}
-- trafficbyasin at AU_GET_SALES_AND_TRAFFIC_REPORT/trafficByAsin from {{ ref('au_get_sales_and_traffic_report') }}
where 1 = 1

